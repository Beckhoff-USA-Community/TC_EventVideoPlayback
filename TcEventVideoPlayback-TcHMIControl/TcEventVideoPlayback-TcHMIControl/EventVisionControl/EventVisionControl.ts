/*
 * Generated 4/15/2024 12:59:44 PM
 * Copyright (C) 2024
 */
module TcHmi {
    export module Controls {
        export module EventVision {
            export class EventVisionControl extends TcHmi.Controls.Beckhoff.TcHmiEventGrid {

                /*
                Attribute philosophy
                --------------------
                - Local variables are not set while definition in class, so they have the value 'undefined'.
                - On compile the Framework sets the value from HTML or from theme (possibly 'null') via normal setters.
                - The "changed detection" in the setter will result in processing the value only once while compile.
                - Attention: If we have a Server Binding on an Attribute the setter will be called once with null to initialize and later with the correct value.
                */


                protected __videoButton: System.baseTcHmiControl | undefined;
                protected __virtualDirectory = "/Videos";
                protected __videoCheckRetries = 10;
                protected __videoCheckDelay = 500;

                /**
                 * Constructor of the control
                 * @param {JQuery} element Element from HTML (internal, do not use)
                 * @param {JQuery} pcElement precompiled Element (internal, do not use)
                 * @param {TcHmi.Controls.ControlAttributeList} attrs Attributes defined in HTML in a special format (internal, do not use)
                 * @returns {void}
                 */
                constructor(element: JQuery, pcElement: JQuery, attrs: TcHmi.Controls.ControlAttributeList) {
                    /** Call base class constructor */
                    super(element, pcElement, attrs);
                }

                protected __elementTemplateRoot!: JQuery;

				/**
                  * If raised, the control object exists in control cache and constructor of each inheritation level was called.
                  */
                public __previnit() {
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
                public __init() {
                    super.__init();
                }

                /**
                * Is called by the system after the control instance gets part of the current DOM.
                * Is only allowed to be called from the framework itself!
                */
                public __attach() {
                    super.__attach();

                    /**
                     * Initialize everything which is only available while the control is part of the active dom.
                     */
                }

                /**
                * Is called by the system after the control instance is no longer part of the current DOM.
                * Is only allowed to be called from the framework itself!
                */
                public __detach() {
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
                public destroy() {
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

                
                public __showDetails() {
                    if (!this.__allowDetailsPopup)
                        return;
                    
                    if (!this.__detailsPopup)
                    // @ts-ignore;
                        this.__detailsPopup = new DetailsVideoPopup(this.__elementDetailsPopup[0], this)


                    //OOB Update//
                    this.__detailsPopup?.update(this.__datagrid.getSelectedRowValue()), this.__detailsPopup?.show();

                    //Video Button Update//
                    // @ts-ignore;
                    this.__detailsPopup?.updateVideoButton(this.__virtualDirectory, this.__videoCheckRetries, this.__videoCheckDelay);
                }


                public getVirtualDrive() { return this.__virtualDirectory; }
                public getVideoCheckRetries() { return this.__videoCheckRetries; }
                public getVideoCheckDelay() { return this.__videoCheckDelay; }

                public setVirtualDrive(value: string) { this.__virtualDirectory = value;}
                public setVideoCheckRetries(value: number) { this.__videoCheckRetries = value;}
                public setVideoCheckDelay(value: number) { this.__videoCheckDelay = value;}
            }
        }
    }
}
/**
* Register Control
*/
TcHmi.Controls.registerEx('EventVisionControl', 'TcHmi.Controls.EventVision', TcHmi.Controls.EventVision.EventVisionControl);
