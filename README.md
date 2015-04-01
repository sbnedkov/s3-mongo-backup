# S3 MongoDB Backup

Simple backup of a MongoDB database to Amazon S3, with email notification via SMTP.
Based upon the [s3-mysql-backup gem](https://github.com/7compass/s3-mysql-backup) by [Seventh Compass, Inc](https://github.com/7compass).

[![Gem Version](https://badge.fury.io/rb/s3-mongo-backup.svg)](http://badge.fury.io/rb/s3-mongo-backup)
[![Build Status](https://travis-ci.org/mattycourtney/s3-mongo-backup.svg?branch=master)](https://travis-ci.org/mattycourtney/s3-mongo-backup)
[![Dependency Status](https://gemnasium.com/mattycourtney/s3-mongo-backup.svg)](https://gemnasium.com/mattycourtney/s3-mongo-backup)
[![Code Climate](https://codeclimate.com/github/mattycourtney/s3-mongo-backup/badges/gpa.svg)](https://codeclimate.com/github/mattycourtney/s3-mongo-backup)
[![Coverage Status](https://coveralls.io/repos/mattycourtney/s3-mongo-backup/badge.svg)](https://coveralls.io/r/mattycourtney/s3-mongo-backup)


## What does it do?

It makes a gzipped and timestamped local backup of the specified
database using mongodump.  The local backup is then copied to
Amazon S3, and the results are emailed to the specified recipient.

Local and S3 backups are retained at this schedule:
- keep 30 days complete
- keep 90 days weekly beyond that
- keep only monthly after that

The email summary is a short email like:

    From:    my-user@example.com
    To:      my-recipient@example.com
    Date:    2012-12-22
    Subject: sql backup: my_database_name: 42.0 MB

    my_database_name.20121222.170134.mongodb.backup.gz


## Configuration

Configure with a YAML file:

```yaml

# backup_dir            where to store the local backups, default is ~/s3_mysql_backups
backup_dir: ~/s3_mysql_backups
# remote_dir            OPTIONAL, where to store the remote backups, default is the root of your s3_bucket
remote_dir: /path/to/remote/backups

# s3_access_key_id      your Amazon S3 access_key_id
# s3_secret_access_key  your Amazon S3 secret_access_key
# s3_bucket             your Amazon S3 bucket for the backups
# s3_server             OPTIONAL, your non-Amazon S3-compatible server
s3_access_key_id: my-key
s3_secret_access_key: my-secret
s3_bucket: my-bucket

# dump_host             OPTIONAL, your mongodb host name
# dump_port             OPTIONAL, your mongodb port

# mail_to               where to send the backup summary email
mail_to: recipient@example.com

# Mail credentials
mail_user: me@example.com
mail_pass: example_password
mail_from: noreply@example.com  # OPTIONAL, defaults to mail_user
mail_domain: smtp.example.com   # OPTIONAL, defaults to: smtp.gmail.com
mail_port: 587                  # OPTIONAL, defaults to: 587
mail_authentication: login      # OPTIONAL, defaults to: :login
mail_start_tls: true            # OPTIONAL, defaults to: true

```


## Installation

    gem install s3-mongo-backup


## Usage

From Ruby:

    S3MongoBackup.new("database_name", "/path/to/s3-mongo-backup-config.yml").run
    or
    S3MongoBackup.new("database_name", { hash: of_options }).run

From command line:

    s3-mongo-backup database_name /path/to/s3-mongo-backup-config.yml

If you're using bundler:

    cd /path/to/my/app && bundle exec s3-mongo-backup database_name /path/to/s3-mongo-backup-config.yml


## Todo

Write tests


## Changelog
- 2015-04-02 2.1.2 Forked s3-mysql-backup as s3-mongo-backup
- 2014-03-24 2.1.1 Bugfix for deleting old backups not happening
- 2013-10-13 2.1.0 Allow other mail hosts, allow Hash config at runtime (https://github.com/7compass/s3-mysql-backup/pull/7)
- 2013-06-01 1.2.2 Bugfix for passwords with spaces
- 2013-06-01 1.2.1 Added mysql host option (github.com/sagrimson)
- 2013-05-30 1.1.0 Added support for S3-compatible services, e.g. DreamObjects (thanks to John N. Milner - github.com/jnm)

## Credits

2015+ Matty Courtney
2008+ Seventh Compass
