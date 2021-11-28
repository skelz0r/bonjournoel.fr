# bonjournoel.fr [![Build](https://github.com/skelz0r/bonjournoel.fr/actions/workflows/build.yml/badge.svg)](https://github.com/skelz0r/bonjournoel.fr/actions/workflows/build.yml)

Your daily dose of christmas porn

## Requirements

- ruby 2.7.2

## Install

```sh
bundle install
```

Check `.env.example` for env

You have to configure Google Cloud Vision API and Google Drive API, please follow the
[QuickStart](https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-vision#quick-start)
and the
[Authentication](https://github.com/googleapis/google-cloud-ruby/blob/master/google-cloud-vision/AUTHENTICATION.md)
page to get your json keyfile.

You have to enable the following API:

- Google Vision
- Google Drive
- Google Spreadsheet

## Run in local

```sh
./bin/local.sh
```

Then visit `http://127.0.0.1:4000/`

## Generate today post manually

Run:

```sh
bundle exec ruby bin/generate_noel_post.rb
```

## Tweet today's noel

Check `.env.local` for credentials

Run:

```sh
bundle exec ruby bin/tweet_noel.rb `date +%Y-%m-%d`
```

## Configure Github Action for today noel

Add the following secrets:

- `FLICKR_API_KEY` : Flickr API key
- `GOOGLE_CREDENTIALS_BASE_64` : JSON key for the Google Vision API as url safe
  base64. You can use `./bin/encode_google_vision_json_key.rb` to generate this file
- `ACCESS_TOKEN` : Github Personal Access Token with at least write access to
  repositories: can trigger builds from push to develop

## Analytics

👉 https://bonjournoel.goatcounter.com/
