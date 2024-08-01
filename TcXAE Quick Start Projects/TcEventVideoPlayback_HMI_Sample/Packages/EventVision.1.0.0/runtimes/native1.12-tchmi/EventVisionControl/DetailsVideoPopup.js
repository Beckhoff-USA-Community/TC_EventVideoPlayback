// Keep these lines for a best effort IntelliSense of Visual Studio 2017 and higher.
/// <reference path="./../../TcHmiProject1/Packages/Beckhoff.TwinCAT.HMI.Framework.12.760.59/runtimes/native1.12-tchmi/TcHmi.d.ts" />


class DetailsVideoPopup extends TcHmi.Controls.Beckhoff.TcHmiEventGridPopups.DetailsPopup {
    constructor(element, control) {
        super(element, control);

        this.__virtualDirectory = "/Videos";
        this.__videoCheckRetries = 10;
        this.__videoCheckDelay = 500;

        this.__videoVideoCheckAttempts = 0;


        this.__videoButton;


        this.dialog;
        this.createVideoPopup();
        this.createVideoButton();
    }

    createVideoPopup() {
        this.dialog = $("<div>", {
            id: "dialog-form",
            title: "Video Playback"
        }).dialog({
            autoOpen: false,
            height: 400,
            width: 350,
            modal: true,

            close: function () {
            }
        });


    }

    createVideoButton() {
        this.__videoButton = TcHmi.ControlFactory.createEx("TcHmi.Controls.Beckhoff.TcHmiButton", "newButtonId", {
            "data-tchmi-width": 160,
            "data-tchmi-height": 30,
            "data-tchmi-text": "PLAY VIDEO",
            "data-tchmi-tooltip": "Show Me The Video"
        }, this.__parentControl);

        this.__videoButton.getElement().addClass("TcHmi_Controls_EventVision_EventVisionControl_video-button");

        this.__elementFooter.appendChild(this.__videoButton.getElement()[0]);

        this.__eventDestroyers.push(TcHmi.EventProvider.register(this.__videoButton.getId() + ".onPressed", () => this.dialog.dialog("open")));
    }

    updateVideoButton(virtualDirectory, videoCheckRetries, videoCheckDelay) {
        if (this.__event?.params?.jsonAttribute?.includes("CameraName") === false) {
            this.__videoButton.getElement().addClass("TcHmi_Controls_EventVision_EventVisionControl_no-video");
            return;
        }

        this.__virtualDirectory = virtualDirectory;
        this.__videoCheckRetries = videoCheckRetries;
        this.__videoCheckDelay = videoCheckDelay;


        this.__videoButton.getElement().removeClass("TcHmi_Controls_EventVision_EventVisionControl_no-video");

        this.setVideoPopupHTML(this.getVideoSource());
        this.__videoVideoCheckAttempts = 0;

        this.WaitingForVideo();
    }



    async CheckForVideo() {
        let exists = false;
        let filePath = this.getVideoPath();
        let fileName = this.getVideoFileName();
        //declare promise to call the List Files function to list the files in the /Videos virtual directory
        //if thre is an error, return rejected. else return resolved.

        var check_Promise = new Promise (async function (resolve, reject) {

            TcHmi.Server.writeSymbol("ListFiles", filePath, function (data) {
                //If there is an error log it, and leave the function
                if (data.error) {
                    reject("error getting file list");
                    return;
                }
                //No error, make sure the results exist.
                if (data.results === undefined) {
                    reject("error getting results from File List");
                    return;
                }
                let files = data.results[0];
                if (files.value === undefined) {
                    reject("What we got back from the ListFiles function isn't what was expected.");
                    return;
                }

                if (files.value[fileName] === undefined) {
                    console.log(fileName, " has not been found")
                    resolve(false);
                    return;
                }
                console.log(fileName, " has been found")
                resolve(true);
            });//writeSymbol
        });//check_Promise declaration

        await check_Promise.then(
            (value) => {
                this.__videoVideoCheckAttempts++;
                if (value)
                    this.VideoReady();
                else
                    this.WaitingForVideo();
            },
            (error) => { console.log(error); });
        //console.log("exists is being returned as:",exists);

        return exists;
    }


    //Update button to match video status//

    WaitingForVideo() {
        if (this.__videoVideoCheckAttempts >= this.__videoCheckRetries) {
            this.VideoUnavailable();
            return;
        }

        this.__videoButton.setText("WAITING FOR VIDEO");
        this.__videoButton.setIsEnabled(false);


        let _this = this;
        if (this.__videoVideoCheckAttempts > 0)
            setTimeout(function () { _this.CheckForVideo(); }, this.__videoCheckDelay);
        else
            this.CheckForVideo();        
    }

    VideoReady() {
        this.__videoButton.setText("PLAY VIDEO");
        this.__videoButton.setIsEnabled(true);
    }
    VideoUnavailable() {
        this.__videoButton.setText("VIDEO UNAVAILABLE");
        this.__videoButton.setIsEnabled(false);
    }


    //Getting Video Path
    getVideoPath() {
        return `${this.__virtualDirectory}/${this.getCameraName()}`;
    }
    getVideoSource() {
        return `${this.getVideoPath()}/${this.getVideoFileName()}`;

        //return "Videos/Camera1/2024-04-30-13-51-14.mp4";
    }
    getCameraName() {
        return JSON.parse(this.__event.params.jsonAttribute.replace(/(['"])?([a-z0-9A-Z_]+)(['"])?\s*:/g, '"$2": ')).CameraName;
    }

    getVideoFileName() {
        return moment(this.__event.timeRaised).format("YYYY-MM-DD-HH-mm-ss").concat(".mp4");
    }


    
    setVideoPopupHTML(src) {
        this.dialog.html(`<video class="TcHmi_Controls_Beckhoff_TcHmiVideo-template-content tchmi-video-template-content" controls="" playsinline="" poster="" autoplay="" loop=""><source src=${src} type="video/mp4">HTML5 Video support is missing...</video>`);
    }
}