const Customers = artifacts.require("Customers");

contract("Customers", accounts => {
    const[account1, account2, account3] = accounts;
    let instance;

    it("can register as a customer", async() => {
      instance = await Customers.deployed();

      let expectedDeliveryAddress = "5 Stevens Drive #01-01";
      await instance.registerAsCustomer(expectedDeliveryAddress, { from: account1 });
      let [deliveryAddress, isCustomer] = await instance.customers(account1);

      assert.equal(deliveryAddress, expectedDeliveryAddress);
    });

    it("can validate a customer", async() => {
      assert(await instance.checkIsCustomer(account1));
      assert.equal(await instance.checkIsCustomer(account2), false);
    });
});
