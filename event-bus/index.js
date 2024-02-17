
const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
app.use(bodyParser.json());

const events = [];

app.post("/events", (req, res) => {
  const event = req.body;

  events.push(event);

  // posts
  axios.post(`${process.env.REACT_APP_POSTS_URL}/events`, event).catch((err) => {
    console.log(err.message);
  });

  // comments
  axios.post(`${process.env.REACT_APP_COMMENTS_URL}/events`, event).catch((err) => {
    console.log(err.message);
  });

  // query
  axios.post(`${process.env.REACT_APP_QUERY_URL}/events`, event).catch((err) => {
    console.log(err.message);
  });

  // moderation
  axios.post(`${process.env.REACT_APP_MODERATION_URL}/events`, event).catch((err) => {
    console.log(err.message);
  });
  res.send({ status: "OK" });
});

app.get("/events", (req, res) => {
  res.send(events);
});

app.listen(4005, () => {
  console.log("Listening on 4005");
});
