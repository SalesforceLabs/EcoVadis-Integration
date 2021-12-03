/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getSettings from '@salesforce/apex/EcoVadis_SetupHelper.getSettings';
import saveSettings from '@salesforce/apex/EcoVadis_SetupHelper.saveSettings';
import testConnection from '@salesforce/apex/EcoVadis_SetupHelper.testConnection';
import STATUS_ICONS from '@salesforce/resourceUrl/images';


export default class EcoVadisSetup extends LightningElement {

    passIcon = STATUS_ICONS + '/images/GreenThumb.png';
    failIcon = STATUS_ICONS + '/images/RedThumb.png';
    logoIcon = STATUS_ICONS + '/images/EcoVadisLogo.png';
    
    @track settings;
    environment;
    testDisabled;
    testResults;
    showPassword = false;

    environmentOptions = [
        {
            label: "Live", 
            value: "https://api.ecovadis-survey.com/"
        },
        {
            label: "Sandbox", 
            value: "https://api-sandbox.ecovadis-survey.com/"
        }
    ];

    get saveDisabled() {
        return (!this.settings.ecovadis__Environment_URL__c || !this.settings.ecovadis__Username__c || !this.settings.ecovadis__Password__c);
    }

    get showPasswordIcon() {
        return (this.showPassword ? 'utility:hide' : 'utility:preview');
    }

    get showPasswordAltText() {
        return (this.showPassword ? 'Hide Password' : 'Show Password');
    }

    get passwordInputType() {
        return (this.showPassword ? 'text' : 'password');
    }

	connectedCallback() {
        this.testDisabled = true;
        this.testResults = null;
		this.getSettings();
	}
    
    getSettings() {
		getSettings()
			.then(result => {
                console.log('settings: ', JSON.parse(JSON.stringify(result)));
				this.settings = result;
                if (this.settings.ecovadis__Environment_URL__c) {
                    this.environment = this.settings.ecovadis__Environment_URL__c;
                }
                //Enable the test button only if there are values in all three fields
                if (this.settings.ecovadis__Environment_URL__c && this.settings.ecovadis__Username__c && this.settings.ecovadis__Password__c) {
                    this.testDisabled = false;
                }
			})
			.catch(error => {
				this.handleErrors(error);
		})
	}

    handleShowPasswordChange(event) {
        this.showPassword = ! this.showPassword;
    }

    handleEnvironmentChange(event) {
        this.settings.ecovadis__Environment_URL__c = event.detail.value;
        console.log("handleEnvironmentChange: set environment URL to " + event.detail.value);

        //Disable testing until changes are saved
        this.testDisabled = true;
        this.testResults = null;
    }

    handleUsernameChange(event) {
        this.settings.ecovadis__Username__c = event.detail.value;

        //Disable testing until changes are saved
        this.testDisabled = true;
        this.testResults = null;
    }

    handlePasswordChange(event) {
        this.settings.ecovadis__Password__c = event.detail.value;

        //Disable testing until changes are saved
        this.testDisabled = true;
        this.testResults = null;
    }

    handleSave(event) {
        console.log('handleSave: ', JSON.parse(JSON.stringify(this.settings)));

        if (!this.settings.ecovadis__Environment_URL__c || !this.settings.ecovadis__Username__c || !this.settings.ecovadis__Password__c) {
            this.handleErrors({message: 'Missing data.  Complete all fields and try again'});
            return;
        }

        saveSettings({ settings: this.settings })
            .then(result => {
                this.handleConfirmation('Settings have been saved');
                this.testDisabled = false;
            })
            .catch(error => {
                this.handleErrors(error);
        })
    }

    handleTest(event) {
        console.log('handleTest');

        testConnection()
        .then(result => {
            this.testResults = result;
        })
        .catch(error => {
            this.handleErrors(error);
        });
    }

    get showTestStatus() {
        return (this.testResults !== null);
    }
    
    handleConfirmation(message) {
        console.log('handleConfirmation');
        const evt = new ShowToastEvent({
            title: "Confirmation",
            message: message,
            variant: "success",
        });
        !window.dispatchEvent(evt);
    }

    handleErrors(errors) {
        console.log('handleErrors: ' + JSON.stringify(errors));

        var singleError;
        if (errors && errors.body) {
            singleError = JSON.stringify(errors.body);
    
        } else if (errors && errors.message) {
            // Maybe it is just a single error itself
            singleError = errors.message;
        }
    
        // Configure error toast
        let toastParams = {
            title: "Error",
            message: singleError,
            variant: "error"
        };
    
        // Fire error toast
        const evt = new ShowToastEvent(toastParams);
        !window.dispatchEvent(evt);
    }
    
}