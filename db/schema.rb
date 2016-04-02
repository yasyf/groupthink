# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160402111950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hashtags", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags_tweets", id: false, force: :cascade do |t|
    t.integer "tweet_id",   null: false
    t.integer "hashtag_id", null: false
  end

  add_index "hashtags_tweets", ["hashtag_id", "tweet_id"], name: "index_hashtags_tweets_on_hashtag_id_and_tweet_id", using: :btree
  add_index "hashtags_tweets", ["tweet_id", "hashtag_id"], name: "index_hashtags_tweets_on_tweet_id_and_hashtag_id", using: :btree

  create_table "links", force: :cascade do |t|
    t.text     "url",        null: false
    t.text     "title",      null: false
    t.text     "summary",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links_tweets", id: false, force: :cascade do |t|
    t.integer "tweet_id", null: false
    t.integer "link_id",  null: false
  end

  add_index "links_tweets", ["link_id", "tweet_id"], name: "index_links_tweets_on_link_id_and_tweet_id", using: :btree
  add_index "links_tweets", ["tweet_id", "link_id"], name: "index_links_tweets_on_tweet_id_and_link_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string   "username",   null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lists", ["username", "name"], name: "index_lists_on_username_and_name", unique: true, using: :btree

  create_table "tweets", force: :cascade do |t|
    t.string   "identifier"
    t.integer  "user_id",                                    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "posted_at",  default: '2016-04-02 11:29:45', null: false
    t.integer  "favorites",  default: 0,                     null: false
    t.integer  "retweets",   default: 0,                     null: false
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                                       null: false
    t.string   "identifier",                                 null: false
    t.text     "username",                                   null: false
    t.datetime "oldest",     default: '2016-04-02 11:29:45', null: false
    t.datetime "newest",     default: '2016-04-02 11:29:45', null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_foreign_key "tweets", "users"
end
