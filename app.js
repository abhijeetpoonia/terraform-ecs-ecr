const express = require('express');
const app = express();
const PORT = 8000;
const HOST = '0.0.0.0';

// Middleware to serve static files (if needed)
app.use(express.static('public'));

// Route that displays the message
app.get('/', (req, res) => {
    res.send('<h1>Hello World , This is my App</h1>');
});

// Start the server on 0.0.0.0
app.listen(PORT, HOST, () => {
    console.log(`Hey you are champion`);
    console.log(`Server is running on http://${HOST}:${PORT}`);
    console.log(`Also accessible via http://localhost:${PORT}`);
});
