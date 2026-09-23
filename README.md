# QookieQloud CMP – Google Tag Manager Community Template

This template integrates [QookieQloud](https://qookieqloud.com) with Google Tag Manager and establishes Google Consent Mode v2 default states.

## Features

- **Google Consent Mode v2 Support:** Automatically defines `ad_storage`, `analytics_storage`, `ad_user_data`, and `ad_personalization` default states.
- **Asynchronous Loader:** Loads the QookieQloud CMP loader asynchronously via Cloudflare CDN.
- **API v2 Site Key:** Uses the public Site Key for the domain when supplied; leaving it empty keeps existing API v1 behavior.
- **Certified Developer ID:** Automatically registers QookieQloud's verified CMP partner ID with Google APIs.

## Installation

1. In Google Tag Manager, navigate to **Templates > Tag Templates > New**.
2. Click the top-right menu and choose **Import**, then select `template.tpl`.
3. Save the template.
4. Create a new Tag using **QookieQloud CMP**, trigger it on **Consent Initialization - All Pages**.

Enter the public Site Key generated for the domain in QookieQloud to use API v2. If the field is empty, the existing API v1 loader is used for migration. The template passes the v2 key as `site_key`; direct website installations should continue using the equivalent `data-site-key` script attribute.

## License

Apache License 2.0. See [LICENSE](LICENSE) for details.
