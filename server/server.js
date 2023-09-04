const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');
const shopRoutes = require('./routes/shops.js'); // Assurez-vous d'avoir ce fichier dans le dossier /routes
const app = express();

// Configuration
dotenv.config();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json()); // Pour parser les requêtes JSON
app.use((err, req, res, next) => {
  res.status(500).json({ message: err.message });
});

// Connexion à MongoDB
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

mongoose.connection.on('connected', () => {
  console.log('Connected to MongoDB');
});

// Routes
const shopsRouter = require('./routes/shops'); // Assurez-vous que le chemin est correct
app.use('/shops', shopsRouter);

// Démarrage du serveur
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
