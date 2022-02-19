const express = require("express");
const cors = require("cors");
const customerRouter = require("./routes/customer");
const sellerRouter = require("./routes/seller");

require("dotenv").config();

const app = express();
app.use(express.json());
app.use(cors());

app.use("/customer", customerRouter);
app.use("/seller", sellerRouter);

const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log("server running on port 3001");
});
