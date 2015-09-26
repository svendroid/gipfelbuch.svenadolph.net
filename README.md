# Gipfelbuch

Blog über meine Wanderungen.

# Setup
* 'bundle install' - use bundler to install all needed gems defined in Gemfile
* 'jekyll build'

## Deploy to ftp server
* change url in `_config.yml`
* make sure lftp is installed - e.g download [here](http://rudix.org/packages/lftp.html)
* ftp settings in `ftp_configuration.yml`
* execute `thor ftp:deploy`
* for more infos about thor see [thor getting started](https://github.com/erikhuda/thor/wiki/Getting-Started)

## Neuer Post
* Neuen Post Erstellen: YYYY-MM-DD-titel
* Dateiname wird für gpx-file & Bilderverzeichnis verwendet -> gleicher Name
* `jekyll serve` - um alle zu überprüfen lokal
* `jekyll build` - Seite in \_site Ordner erstellen
* `thor ftp:deploy` - um \_site Verzeichnis auf ftp zu deployen

# TODO:

## Bugs:
* release script which commits \_site to release branch

## Features:
* fullscreen image view
* some kind of hybrid image map view
* ...

## Thanks

Using the HPSTR Jekyll Theme (https://github.com/mmistakes/hpstr-jekyll-theme)
