___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "QookieQloud CMP - Cookie Banner & Consent Mode",
  "brand": {
    "id": "github.com_qodli-ab",
    "displayName": "QookieQloud"
  },
  "developerId": "dNWFlZT",
  "categories": [
    "TAG_MANAGEMENT",
    "PERSONALIZATION"
  ],
  "description": "Integrate QookieQloud Cookie Consent Manager with Google Consent Mode v2 seamlessly.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "siteKey",
    "displayName": "QookieQloud Site Key",
    "simpleValueType": true,
    "help": "Optional for existing API v1 installations. Add the public Site Key generated for this domain to use API v2."
  },
  {
    "type": "CHECKBOX",
    "name": "enableGcmv2",
    "checkboxText": "Enable Google Consent Mode v2 Default States",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Sets default consent states (ad_storage, analytics_storage, ad_user_data, ad_personalization to denied) with wait_for_update."
  },
  {
    "type": "PARAM_TABLE",
    "name": "regionSettings",
    "displayName": "Regional Default Consent Settings",
    "help": "Configure region-specific default consent settings (ISO 3166-2 region codes e.g. SE, DE, US-CA, EEA). Leave Region blank for global default fallback.",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "region",
          "displayName": "Region Code (e.g. SE, DE, US-CA)",
          "simpleValueType": true
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "ad_storage",
          "displayName": "ad_storage",
          "selectItems": [
            {
              "value": "denied",
              "displayValue": "Denied"
            },
            {
              "value": "granted",
              "displayValue": "Granted"
            }
          ],
          "simpleValueType": true,
          "defaultValue": "denied"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "analytics_storage",
          "displayName": "analytics_storage",
          "selectItems": [
            {
              "value": "denied",
              "displayValue": "Denied"
            },
            {
              "value": "granted",
              "displayValue": "Granted"
            }
          ],
          "simpleValueType": true,
          "defaultValue": "denied"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "ad_user_data",
          "displayName": "ad_user_data",
          "selectItems": [
            {
              "value": "denied",
              "displayValue": "Denied"
            },
            {
              "value": "granted",
              "displayValue": "Granted"
            }
          ],
          "simpleValueType": true,
          "defaultValue": "denied"
        },
        "isUnique": false
      },
      {
        "param": {
          "type": "SELECT",
          "name": "ad_personalization",
          "displayName": "ad_personalization",
          "selectItems": [
            {
              "value": "denied",
              "displayValue": "Denied"
            },
            {
              "value": "granted",
              "displayValue": "Granted"
            }
          ],
          "simpleValueType": true,
          "defaultValue": "denied"
        },
        "isUnique": false
      }
    ],
    "enclosingCondition": "enableGcmv2"
  },
  {
    "type": "TEXT",
    "name": "waitForUpdate",
    "displayName": "Wait For Update (ms)",
    "simpleValueType": true,
    "defaultValue": "500",
    "help": "Milliseconds to wait for consent update before tags fire (default: 500ms).",
    "enclosingCondition": "enableGcmv2"
  },
  {
    "type": "TEXT",
    "name": "cdnUrl",
    "displayName": "Custom CDN Loader URL (Optional)",
    "simpleValueType": true,
    "defaultValue": "",
    "help": "Optional custom loader URL. If empty, the template selects the v2 loader when a Site Key is provided and the v1 loader otherwise."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const setDefaultConsentState = require('setDefaultConsentState');
const encodeUriComponent = require('encodeUriComponent');

const parseRegions = function(regionStr) {
  if (!regionStr) return null;
  const parts = regionStr.split(',');
  const result = [];
  for (let i = 0; i < parts.length; i++) {
    const trimmed = parts[i].trim();
    if (trimmed.length > 0) {
      result.push(trimmed);
    }
  }
  return result.length > 0 ? result : null;
};

if (data.enableGcmv2) {
  const waitForUpdate = data.waitForUpdate ? (1 * data.waitForUpdate) : 500;
  if (data.regionSettings && data.regionSettings.length > 0) {
    for (let i = 0; i < data.regionSettings.length; i++) {
      const row = data.regionSettings[i];
      const regions = parseRegions(row.region);
      const consentObj = {
        'ad_storage': row.ad_storage || 'denied',
        'analytics_storage': row.analytics_storage || 'denied',
        'ad_user_data': row.ad_user_data || 'denied',
        'ad_personalization': row.ad_personalization || 'denied',
        'wait_for_update': waitForUpdate
      };
      if (regions) {
        consentObj['region'] = regions;
      }
      setDefaultConsentState(consentObj);
    }
  } else {
    setDefaultConsentState({
      'ad_storage': 'denied',
      'analytics_storage': 'denied',
      'ad_user_data': 'denied',
      'ad_personalization': 'denied',
      'wait_for_update': waitForUpdate
    });
  }
}

const siteKey = data.siteKey || '';
const isValidSiteKey = function(key) {
  if (!key) return true;
  if (key.indexOf('qq_pk_') !== 0) return false;
  if (key.length !== 70) return false;
  return true;
};

if (siteKey && !isValidSiteKey(siteKey)) {
  data.gtmOnFailure();
  return;
}

const loaderUrl = data.cdnUrl || (siteKey
  ? 'https://cf-cdn.qookieqloud.com/v2/consentLoader.js'
  : 'https://cf-cdn.qookieqloud.com/consentLoader.js');
if (!siteKey) {
  injectScript(loaderUrl, data.gtmOnSuccess, data.gtmOnFailure);
  return;
}
const separator = loaderUrl.indexOf('?') === -1 ? '?' : '&';
const scriptUrl = loaderUrl + separator + 'site_key=' + encodeUriComponent(siteKey);

injectScript(scriptUrl, data.gtmOnSuccess, data.gtmOnFailure);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": false
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cf-cdn.qookieqloud.com/*"
              },
              {
                "type": 1,
                "string": "https://cdn.qookieqloud.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": false
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created for QookieQloud CMP Google Partner verification.
