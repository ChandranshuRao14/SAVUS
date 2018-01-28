const config = require('./config');
const Twit = require('twit');
const Pusher = require('pusher');

const T = new Twit(config.twitter);

const pusher = new Pusher(config.pusher);

// Get tweets from the hashtags to track

console.log("Starting tweet stream...");

T.get('search/tweets', { q: '#Patience', count: 3 }, (err, data, res) => {
  data.statuses.forEach(tweet => {
    const message = {
      message: tweet.text, 
      username: tweet.user.screen_name, 
      name: tweet.user.name, 
    };
    console.log(message);
    pusher.trigger(config.channel, config.event, message);
  });
});