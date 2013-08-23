# rake db:dump

Adds a `db:dump` Rake task so you can see the contents and schema for all the tables in your `config/database.yml` without needing a SQL client.

Assumes an `environment` Rake task already exists to create the Active Record connection (as it will for Rails projects).

Assumes Rails version 3 or higher and the PostgreSQL adapter.

## Installation

Add this line to your application's Gemfile:

    gem 'rake_db_dump'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rake_db_dump

## Usage

    $ rake db:dump

## Example output
```

_________________________ members table ___________________________________
| Type of id:      integer not null
| Type of team_id: integer not null
| Type of name:    varchar(255) not null

     id: 1
team_id: 1
   name: Jill

     id: 2
team_id: 1
   name: Ted

     id: 3
team_id: 2
   name: Lenny

     id: 4
team_id: 2
   name: Tina
_________________________ teams table _____________________________________
| Type of id:    integer not null
| Type of color: varchar(255) not null

   id: 1
color: green

   id: 2
color: orange
_________________________ schema_migrations table _________________________
| Type of version: varchar(255) not null

version: 20130811234816
```
