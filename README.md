# README

# UCXGaming API

## Description

#### _**This site is designed to be an easy place to store and use various tabletop rpg character sheets. It uses a rails backend with Vue components for the UI interface. It also uses a NoSQL database so as to have an abstracted model structure. This allows for multiple game systems and variations on the character sheets.**

#### _**By Tyler Stephenson, July 24, 2017**_

### Setup/Installation Requirements
* clone <link to repo>
* cd <local repo>
* Setup a MongoDB Atlas account (there is a free version).
* Create a `.env` file in the root dir of the project.
* Add the following structure to the `.env` file replacing the `*****` your info.
  * `MONGODB_USER=*****`
    `MONGODB_PASS=*****`
    `MONGODB_TEST_USER=*****`
    `MONGODB_TEST_PASS=*****`
  * In `config/mongoid.yml` add replace the following with your MongoDB info.
    * `database: YOUR_DATABASE_NAME_development`

      `hosts:`
        `- Your shard 00 info`
        `- Your shard 01 info`
        `- Your shard 02 info`
* run this series of commands:
  * `$ bundle install`
  * `$ npm install`
  * `$ webpack-dev-server`
  * `$ rails s`

## Planning

1. Specs
  * User model.
    * name - string
    * email - string
    * admin - boolean
    * timestamps
  * User validations.
    * presence and uniqueness of email

  * GameSystem model.
    * name - string
    * publisher - string
    * description - string
    * timestamps
  * GameSystem relationships
    * has many CharacterSheets
    * has many Sections, as sectional

  * Character model.
    * char_sheet, boolean
    * sheet_name
    * timestamps
  *  relationships
    * belongs to User
    * belongs to GameSystem
    * has many Sections, as sectional

  * Section model.
    * name - string
  *  relationships
    * belongs to sectional, polymorphic
    * recursively embeds many (embeds itself)
    * embeds many Traits

  * Trait model.
    * name - string
    * timestamps
  *  relationships
    * embeds in Section


### Known Bugs
Still a work in progress.

## Support and Contact details
* Tyler Stephenson
* ilduchea@gmail.com

### Technologies Used

* Ruby
* Rails
* MongoDB
* Mongoid
* VueJS

### License

*This is web page is licensed under the MIT License.*

Copyright (c) 2017 **Tyler Stephenson**
