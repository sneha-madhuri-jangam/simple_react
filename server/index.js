const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

// Sample API
app.get('/api/greeting', (req, res) => {
  res.json({ message: "Hello Sneha, this is your Node API!" });
});

// Another POST example
app.post('/api/data', (req, res) => {
  const { name } = req.body;
  res.json({ message: `Hi ${name}, your data is received!` });
});

// Serve React build
app.use(express.static(path.join(__dirname, 'public')));

// React fallback
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
