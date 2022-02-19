const contractInstance = require("../eth/authify");
const { hashEmail } = require("../utils");
const router = require("express").Router();

router.post("/create", async (req, res) => {
  const { email, name, phone } = req.body;
  console.log(req.body);
  try {
    console.log(hashEmail(email));
    await contractInstance.methods.createCustomer(
      hashEmail(email),
      name,
      phone
    );
    res.status(200).send("Successful");
  } catch (e) {
    res.status(400).json({
      error: "error",
    });
  }
});

router.post("/", async (req, res) => {
  const { email } = req.body;
  console.log(req.body);
  try {
    const res = await contractInstance.getCustomerDetails(hashEmail(email));
    console.log(res);
    res.status(200).json(res);
  } catch (e) {
    res.status(400).json(e);
  }
});

module.exports = router;
