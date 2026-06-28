
const express = require('express');
const { Server } = require('socket.io');
const http = require('http');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: { origin: '*' }
});

// الاتصال الفوري
io.on('connection', (socket) => {
  console.log('مستخدم متصل:', socket.id);
  
  socket.on('join', (userId) => {
    socket.join(userId);
  });
  
  socket.on('message', async (data) => {
    // حفظ الرسالة + توزيعها
    io.to(data.recipientId).emit('new_message', data);
  });
});

server.listen(3000);
