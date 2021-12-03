/*
 * Copyright (c) 2021, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

/**
 * @description controller class for the ecoVadisSetup lwc
 */
public with sharing class EcoVadis_SetupHelper {

    private enum AccessLevels {
		READ_ACCESS,
		UPDATE_ACCESS,
		CREATE_ACCESS,
		DELETE_ACCESS
	}


	/**
	 * @description Retrieves settings from Custom Settings
	 * @return custom setting values
	 */
	@AuraEnabled
	public static EcoVadis_Settings__c getSettings() { 
		ecovadis__EcoVadis_Settings__c settings = EcoVadis_Settings__c.getOrgDefaults();


		String [] esAccessSettings = new String [] {
			'id',
			'ecovadis__Environment_URL__c',
			'ecovadis__Username__c',
			'ecovadis__Password__c'
		};

		// Verify the necessary fields of the custom setting are readable
		checkAccess(
			'ecovadis__EcoVadis_Settings__c',
			EcoVadis_SetupHelper.AccessLevels.READ_ACCESS,
			esAccessSettings
			);

		return settings;
	}

	/**
	 * @description saves updated settings
	 * @param settings - new setting values
	 */
    @AuraEnabled
	public static void saveSettings(EcoVadis_Settings__c settings){

        System.debug('settings: ' + settings);
		// Verify the necessary fields of the custom setting
		String [] esAccessSettings = new String [] {
			'ecovadis__Environment_URL__c',
			'ecovadis__Username__c',
			'ecovadis__Password__c'
		};
		// Verify the necessary fields of the custom setting are readable
		checkAccess(
			'ecovadis__EcoVadis_Settings__c',
			EcoVadis_SetupHelper.AccessLevels.READ_ACCESS,
			esAccessSettings
			);

		if(settings.id == null) {
            ecovadis__EcoVadis_Settings__c existingSettings = ecovadis__EcoVadis_Settings__c.getOrgDefaults();
			settings.id = existingSettings.id;
            settings.SetupOwnerId = UserInfo.getOrganizationId();
		}

		if(settings.id == null)  {
			// Verify the necessary fields of the custom setting are createable
			checkAccess(
				'ecovadis__EcoVadis_Settings__c',
    			EcoVadis_SetupHelper.AccessLevels.CREATE_ACCESS,
				esAccessSettings
				);
			insert settings;

		} else {
			// Verify the necessary fields of the custom setting are updatable
			checkAccess(
				'ecovadis__EcoVadis_Settings__c',
			    EcoVadis_SetupHelper.AccessLevels.UPDATE_ACCESS,
				esAccessSettings
				);
			update settings;
		}
	}

	/**
	 * @description does a simple token request to confirm settings are valid
	 * @return true if the settings enabled an access token response
	 */
    @AuraEnabled
	public static boolean testConnection() {
        return (EcoVadis_BearerFlow.getAccessToken() != null);
    }



	/**
	 * @description checks object and field access levels for various modes
	 * @param objectName - name of object being checked
	 * @param accessLevel - type of access being checked
	 * @param fieldsToCheck - list of field names to verify
	 */
	private static void checkAccess (String objectName, AccessLevels accessLevel, String[] fieldsToCheck) {
		// Get the object description
		SObjectType sObjType = Schema.getGlobalDescribe().get(objectName);
		// Get a map of the object's fields, in case they need to be checked
		Map<String,Schema.SObjectField> m = sObjType.getDescribe().fields.getMap();

		// Check the object first
		switch on accessLevel {
			when READ_ACCESS {
				if (!sObjType.getDescribe().isAccessible()) {
					throw new System.NoAccessException();
				}
				if (fieldsToCheck != null) {
					for (String fieldToCheck : fieldsToCheck) {
						if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
							throw new System.NoAccessException();
						}
					}
				}
			}
			when UPDATE_ACCESS {
				if (!sObjType.getDescribe().isUpdateable() ||
				    !sObjType.getDescribe().isAccessible()) {
					throw new System.NoAccessException();
				}
				if (fieldsToCheck != null) {
					for (String fieldToCheck : fieldsToCheck) {
						if (!m.get(fieldToCheck).getDescribe().isAccessible() ||
						    !m.get(fieldToCheck).getDescribe().isUpdateable()) {
							throw new System.NoAccessException();
						}
					}
				}
			}
			when CREATE_ACCESS {
				if (!sObjType.getDescribe().isCreateable() &&
				    !sObjType.getDescribe().isAccessible()) {
					throw new System.NoAccessException();
				}
				if (fieldsToCheck != null) {
					for (String fieldToCheck : fieldsToCheck) {
						if (!m.get(fieldToCheck).getDescribe().isCreateable() ||
						    !m.get(fieldToCheck).getDescribe().isAccessible()) {
							throw new System.NoAccessException();
						}
					}
				}
			}
			when DELETE_ACCESS {
				if (!sObjType.getDescribe().isDeletable()) {
					throw new System.NoAccessException();
				}
			}
			when else {
				throw new System.NoAccessException();
			}
		}
	}

}
