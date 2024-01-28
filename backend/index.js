const express = require("express");
const ws = require("ws");

const app = express();

let sockets = [];
const wsServer = new ws.Server({ noServer: true });
wsServer.on("connection", (socket) => {
  console.log("game connected");

  sockets.push(socket);
  socket.on("message", (message) => {
    console.log(message.toString());
    sockets.forEach((s) => {
      s.send(message.toString());
    });
  });
});

const server = app.listen(8080);
server.on("upgrade", (request, socket, head) => {
  wsServer.handleUpgrade(request, socket, head, (socket) => {
    wsServer.emit("connection", socket, request);
  });
});
