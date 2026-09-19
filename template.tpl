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
    "type": "CHECKBOX",
    "name": "enableGcmv2",
    "checkboxText": "Enable Google Consent Mode v2 Default States",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Sets default consent states (ad_storage, analytics_storage, ad_user_data, ad_personalization to denied) with a 500ms wait_for_update."
  },
  {
    "type": "TEXT",
    "name": "cdnUrl",
    "displayName": "Custom CDN Loader URL (Optional)",
    "simpleValueType": true,
    "defaultValue": "https://cf-cdn.qookieqloud.com/consentLoader.js",
    "help": "Optional custom URL for QookieQloud consentLoader.js. Defaults to https://cf-cdn.qookieqloud.com/consentLoader.js."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const setDefaultConsentState = require('setDefaultConsentState');

if (data.enableGcmv2) {
  setDefaultConsentState({
    'ad_storage': 'denied',
    'analytics_storage': 'denied',
    'ad_user_data': 'denied',
    'ad_personalization': 'denied',
    'wait_for_update': 500
  });
}

const loaderUrl = data.cdnUrl || 'https://cf-cdn.qookieqloud.com/consentLoader.js';

injectScript(loaderUrl, () => {
  data.gtmOnSuccess();
}, () => {
  data.gtmOnFailure();
});


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
