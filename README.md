# Music social network

- A music social network
  - authentication
  - post
  - follow
  - like
  - comment
  - notification
  - share (in development)
- Ruby on Rails

## I – Instructions
- Make sure you have ruby & rails installed in your machine.

* Ruby version
  - Ruby 2.6.1
  - Rails 5.2.3

* System dependencies
  - SQLite3
  - devise
  - acts_as_votable
  - acts_as_commentable
  - acts_as_follower

* Database creation
  - rake db:create
  - rake db:migrate

* Database initialization

* Run App
  - rails server -p 3000

## II – Database schema ( /db/schema.rb )
- Tables: activities, comments, follows, posts, users, votes

- **activities** - notification
  - trackable_type (post): which type of this activity
  - tackable_id: which object (post) in this activity
  - owner_type (user): which owner type of this activity
  - owner_id: which onwer (user) own this activity

```ruby
create_table "activities", force: :cascade do |t|
  t.string "trackable_type"
  t.integer "trackable_id"
  t.string "owner_type"
  t.integer "owner_id"
  t.string "key"
  t.text "parameters"
  t.string "recipient_type"
  t.integer "recipient_id"
end
```

- **comments**
  - title: title of the comment
  - comment: comment
  - commentable_type (post): which type of object could be commentable
  - commentable_id: which object (post) has been commented
  - user_id: owner of the comment
  - role: type of comment

```ruby
create_table "comments", force: :cascade do |t|
  t.string "title", limit: 50, default: ""
  t.text "comment"
  t.string "commentable_type"
  t.integer "commentable_id"
  t.integer "user_id"
  t.string "role", default: "comments"
end
```

- **follows**
  - followable_type (user): which type of object could be followed
  - followable_id: which object (user) has been followed
  - follower_type (user): which type of object followed the “followable_id”
  - follower_id: which object (user) has followed the “follwable_id”

```ruby
create_table "follows", force: :cascade do |t|
  t.string "followable_type", null: false
  t.integer "followable_id", null: false
  t.string "follower_type", null: false
  t.integer "follower_id", null: false
  t.boolean "blocked", default: false, null: false
end
```

- **posts**
  - attachment (audio/mp3): the audio
  - content: desctiptions, feeds
  - user_id: the onwer of this post

```ruby
create_table "posts", force: :cascade do |t|
  t.string "attachment"
  t.text "content"
  t.integer "user_id"
end
```

- **users**
  - name, email
  - encrypted_password: password encrypted (password literal has never been stored)
  - reset_password_token: the token to reset password
  - reset_password_sent_at: when did the “reset_password_token” send
  - avatar: the link of avatar

```ruby
create_table "users", force: :cascade do |t|
  t.string "name", default: "", null: false
  t.string "email", default: "", null: false
  t.string "encrypted_password", default: "", null: false
  t.string "reset_password_token"
  t.datetime "reset_password_sent_at"
  t.datetime "remember_created_at"
end
```

* **votes** - like
  - votable_type (post):  which type of object could be votable
  - votable_id: which object (post) has been voted
  - voter_type (user): which type of object voted this “vote” (like, dislike)
  - voter_id: which object has voted this “vote”
  - vote_flag: the flag of this “vote”

```ruby
create_table "votes", force: :cascade do |t|
  t.string "votable_type"
  t.integer "votable_id"
  t.string "voter_type"
  t.integer "voter_id"
  t.boolean "vote_flag"
  t.string "vote_scope"
  t.integer "vote_weight"
end
```
