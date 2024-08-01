/*
 * Generated 4/15/2024 12:59:44 PM
 * Copyright (C) 2024
 */
var TcHmi;
(function (TcHmi) {
    let Controls;
    (function (Controls) {
        let EventVision;
        (function (EventVision) {
            class EventVisionControl extends TcHmi.Controls.Beckhoff.TcHmiEventGrid {
                /**
                 * Constructor of the control
                 * @param {JQuery} element Element from HTML (internal, do not use)
                 * @param {JQuery} pcElement precompiled Element (internal, do not use)
                 * @param {TcHmi.Controls.ControlAttributeList} attrs Attributes defined in HTML in a special format (internal, do not use)
                 * @returns {void}
                 */
                constructor(element, pcElement, attrs) {
                    /** Call base class constructor */
                    super(element, pcElement, attrs);
                    this.__virtualDirectory = "/Videos";
                    this.__videoCheckRetries = 10;
                    this.__videoCheckDelay = 500;
                }
                /**
                  * If raised, the control object exists in control cache and constructor of each inheritation level was called.
                  */
                __previnit() {
                    // Fetch template root element
                    this.__elementTemplateRoot = this.__element.find('.TcHmi_Controls_EventVision_EventVisionControl-Template');
                    if (this.__elementTemplateRoot.length === 0) {
                        throw new Error('Invalid Template.html');
                    }
                    // Call __previnit of base class
                    super.__previnit();
                }
                /**
                 * Is called during control initialize phase after attribute setter have been called based on it's default or initial html dom values.
                 * @returns {void}
                 */
                __init() {
                    super.__init();
                }
                /**
                * Is called by the system after the control instance gets part of the current DOM.
                * Is only allowed to be called from the framework itself!
                */
                __attach() {
                    super.__attach();
                    /**
                     * Initialize everything which is only available while the control is part of the active dom.
                     */
                }
                /**
                * Is called by the system after the control instance is no longer part of the current DOM.
                * Is only allowed to be called from the framework itself!
                */
                __detach() {
                    super.__detach();
                    /**
                     * Disable everything which is not needed while the control is not part of the active dom.
                     * No need to listen to events for example!
                     */
                }
                /**
                * Destroy the current control instance.
                * Will be called automatically if system destroys control!
                */
                destroy() {
                    /**
                    * While __keepAlive is set to true control must not be destroyed.
                    */
                    if (this.__keepAlive) {
                        return;
                    }
                    super.destroy();
                    /**
                    * Free resources like child controls etc.
                    */
                }
                __showDetails() {
                    if (!this.__allowDetailsPopup)
                        return;
                    if (!this.__detailsPopup)
                        // @ts-ignore;
                        this.__detailsPopup = new DetailsVideoPopup(this.__elementDetailsPopup[0], this);
                    //OOB Update//
                    this.__detailsPopup?.update(this.__datagrid.getSelectedRowValue()), this.__detailsPopup?.show();
                    //Video Button Update//
                    // @ts-ignore;
                    this.__detailsPopup?.updateVideoButton(this.__virtualDirectory, this.__videoCheckRetries, this.__videoCheckDelay);
                }
                getVirtualDrive() { return this.__virtualDirectory; }
                getVideoCheckRetries() { return this.__videoCheckRetries; }
                getVideoCheckDelay() { return this.__videoCheckDelay; }
                setVirtualDrive(value) { this.__virtualDirectory = value; }
                setVideoCheckRetries(value) { this.__videoCheckRetries = value; }
                setVideoCheckDelay(value) { this.__videoCheckDelay = value; }
            }
            EventVision.EventVisionControl = EventVisionControl;
        })(EventVision = Controls.EventVision || (Controls.EventVision = {}));
    })(Controls = TcHmi.Controls || (TcHmi.Controls = {}));
})(TcHmi || (TcHmi = {}));
/**
* Register Control
*/
TcHmi.Controls.registerEx('EventVisionControl', 'TcHmi.Controls.EventVision', TcHmi.Controls.EventVision.EventVisionControl);
//# sourceMappingURL=EventVisionControl.js.map