//using TcEventVideoPlaybackService;
//
//var builder = Host.CreateApplicationBuilder(args);
//builder.Services.AddHostedService<Worker>();
//
//var host = builder.Build();
//host.Run();


using TcEventVideoPlaybackService;
using Microsoft.Extensions.Logging.Configuration;
using Microsoft.Extensions.Logging.EventLog;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Logging;


internal class Program
{
    private static void Main(string[] args)
    {
        HostApplicationBuilder builder = Host.CreateApplicationBuilder(args);
        builder.Services.AddWindowsService(options =>
        {
            options.ServiceName = "TcEventVideoPlayback";
        });

        if (OperatingSystem.IsWindows())
        {
            LoggerProviderOptions.RegisterProviderOptions<
            EventLogSettings, EventLogLoggerProvider>(builder.Services);
        }

        //builder.Services.AddSingleton<JokeService>();
        builder.Services.AddHostedService<WindowsBackgroundService>();

        IHost host = builder.Build();
        host.Run();
    }
}