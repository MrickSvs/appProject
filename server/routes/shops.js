const express = require("express");
const router = new express.Router();
const Shop = require("../models/shops");

router.get("/", async (req, res) => {
  try {
    const shops = await Shop.find();
    res.json(shops);
  } catch (err) {
    res.status(500).json({message: err.message});
  }
});

module.exports = router;
