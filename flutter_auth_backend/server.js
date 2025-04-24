const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(bodyParser.json());

// MongoDB connection
mongoose.connect("mongodb://localhost:27017/flutter_auth", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// User Schema
const UserSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
});

const User = mongoose.model("User", UserSchema);

// Register Route
app.post("/register", async (req, res) => {
  const { username, email, password } = req.body;
  const existingUser = await User.findOne({ email });

  if (existingUser) return res.status(400).json({ message: "User already exists" });

  const hashedPassword = await bcrypt.hash(password, 10);
  const newUser = new User({ username, email, password: hashedPassword });
  await newUser.save();

  res.json({ message: "User registered successfully!" });
});

// Login Route
app.post("/login", async (req, res) => {
    try {
      const { email, password } = req.body;
  
      // Check if user exists in the database
      const user = await User.findOne({ email });
      if (!user) {
        return res.status(400).json({ message: "Invalid email or password" });
      }
  
      // Compare hashed password
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ message: "Invalid email or password" });
      }
  
      // Generate JWT token
      const token = jwt.sign({ id: user._id }, "secret_key", { expiresIn: "1h" });
  
      res.json({ message: "Login successful!", token, userName : user.username, userId: user._id });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Server error" });
    }
  });

  // Order Schema (Define this before using Order in checkout route)
const OrderSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  items: [
    {
      productId: String,
      name: String,
      quantity: Number,
      price: Number,
    },
  ],
  totalPrice: Number,
  createdAt: { type: Date, default: Date.now },
});

const Order = mongoose.model("Order", OrderSchema);

  // Checkout Route (Store Order)
app.post("/checkout", async (req, res) => {
  try {
    const { userId, items, totalPrice } = req.body;

    if (!userId || !items || items.length === 0) {
      return res.status(400).json({ message: "Invalid order data" });
    }

    // Check if user exists
    const user = await User.findById(userId);
    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    const newOrder = new Order({ userId, items, totalPrice });
    await newOrder.save();

    res.json({ message: "Order placed successfully!" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
});

// Get Order History for a User
app.get("/orders/:userId", async (req, res) => {
  try {
    const { userId } = req.params;
    const orders = await Order.find({ userId }).sort({ createdAt: -1 }); // recent first
    res.json(orders);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Failed to fetch orders" });
  }
});

  

// Start Server
app.listen(5000, () => console.log("Server running on port 5000"));
