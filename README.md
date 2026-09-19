# QookieQloud CMP – Google Tag Manager Community Template

This template integrates [QookieQloud](https://qookieqloud.com) with Google Tag Manager and establishes Google Consent Mode v2 default states.

## Features

- **Google Consent Mode v2 Support:** Automatically defines `ad_storage`, `analytics_storage`, `ad_user_data`, and `ad_personalization` default states.
- **Asynchronous Loader:** Loads the QookieQloud CMP loader asynchronously via Cloudflare CDN.
- **Certified Developer ID:** Automatically registers QookieQloud's verified CMP partner ID with Google APIs.

## Installation

1. In Google Tag Manager, navigate to **Templates > Tag Templates > New**.
2. Click the top-right menu and choose **Import**, then select `template.tpl`.
3. Save the template.
4. Create a new Tag using **QookieQloud CMP**, trigger it on **Consent Initialization - All Pages**.

## License

Apache License 2.0. See [LICENSE](LICENSE) for details.
