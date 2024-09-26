using TcEventVideoPlaybackService;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System.Drawing.Text;
using System.Text.Json;
using System.Threading.Channels;
using TwinCAT.Ads.Server;

namespace TcEventVideoPlaybackService
{
    class ConfigData
    {
        public string CodecFourCC { get; set; }
        public double VideoDeleteTime { get; set; }
        public ushort AdsPort { get; set; }
        public ulong MaxFolderSize { get; set; } // This is in MB
    }
    public sealed class WindowsBackgroundService(ILogger<WindowsBackgroundService> Logger) : BackgroundService
    {

        AdsImageToVideoServer? AdsServer;
        ConfigData config = new ConfigData();
        static DateTime lastTime = DateTime.MinValue; // Initialize to a default value

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            try
            {
                // User Server Ports must be in between
                // AmsPortRange.CUSTOMER_FIRST (25000) <= PORT <= AmsPort.CUSTOMER_LAST (25999)
                // or
                // AmsPortRange.CUSTOMERPRIVATE_FIRST (26000) <= PORT <= AmsPort.CUSTOMERPRIVATE_LAST (26999)
                // to not conflict with Beckhoff prereserved servers!
                // see https://infosys.beckhoff.com/content/1033/tc3_ads.net/9408352011.html?id=1801810347107555608

                // This presumes that a TwinCAT Router is already running!

                //Read a file here to see the configuration
                try
                {
					//String path = System.Reflection.Assembly.GetExecutingAssembly().Location;
					//path = Path.GetDirectoryName(path);
					//Directory.SetCurrentDirectory(path);
					string jsonFile = "TcEventVideoPlaybackService.config.json";
                    string jsonString = File.ReadAllText(jsonFile);
                    if (jsonString is not null)
                    {
                        config = JsonSerializer.Deserialize<ConfigData>(jsonString);
                    }
                    else
                    {
                        config.CodecFourCC = "avc1";
                        config.VideoDeleteTime = 10;
                        config.AdsPort = 26128;
                        config.MaxFolderSize = 250;    // 1GB of files allowed
                    }

                }
                catch (FileNotFoundException)
                {
                    Logger.LogError("config file not found");
                    config.CodecFourCC = "avc1";
                    config.VideoDeleteTime = 5;
                    config.AdsPort = 26129;
                    config.MaxFolderSize = 250;    // 1GB of files allowed
                }
                catch (JsonException e)
                {
                    Logger.LogError("Error Parsing config file: " + e.Message);
                    config.CodecFourCC = "avc1";
                    config.VideoDeleteTime = 5;
                    config.AdsPort = 26129;
                    config.MaxFolderSize = 250;    // 1GB of files allowed
                }


                AdsServer = new AdsImageToVideoServer(config.AdsPort, "AdsImageToVideoAdsServer", Logger, config.VideoDeleteTime, config.CodecFourCC,config.MaxFolderSize);
                Task[] serverTasks = new Task[1];
                serverTasks[0] = AdsServer.ConnectServerAndWaitAsync(stoppingToken);

                
                while (!stoppingToken.IsCancellationRequested)
                {
                    Thread.Sleep(1000);
                }


                Task shutdownTask = Task.Run(async () =>
                {
                    await Task.WhenAll(serverTasks);
                    Logger.LogWarning("All AdsServers closed down.!");
                });

 
                AdsServer.Disconnect();


                await shutdownTask; // Wait for Shutdown of both Servers


            }
            catch (OperationCanceledException)
            {
                Logger.LogWarning("OperationCanceledExeption");
                // When the stopping token is canceled, for example, a call made from services.msc,
                // we shouldn't exit with a non-zero exit code. In other words, this is expected...
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "{Message}", ex.Message);

                // Terminates this process and returns an exit code to the operating system.
                // This is required to avoid the 'BackgroundServiceExceptionBehavior', which
                // performs one of two scenarios:
                // 1. When set to "Ignore": will do nothing at all, errors cause zombie services.
                // 2. When set to "StopHost": will cleanly stop the host, and log errors.
                //
                // In order for the Windows Service Management system to leverage configured
                // recovery options, we need to terminate the process with a non-zero exit code.
                Environment.Exit(1);
            }
        }
    }
}
