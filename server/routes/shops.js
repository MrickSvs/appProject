const express = require('express');
const router = express.Router();
const Shop = require('../models/shops'); // Assurez-vous que le chemin est correct

// Endpoint pour récupérer tous les shops
router.get('/', async (req, res) => {
    try {
        const shops = await Shop.find();
        res.json(shops);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

module.exports = router;
