const Customers = artifacts.require("Customers");

contract("Customers", accounts => {
    const[account1, account2, account3] = accounts;
    let instance;

    it("can register as a customer", async() => {
      instance = await Customers.new();
      let expectedDeliveryAddress = "5 Stevens Drive #01-01";
      await instance.registerAsCustomer(expectedDeliveryAddress, {from: account1});
      let deliveryAddress = await instance.customers(account1);

      assert.equal(deliveryAddress, expectedDeliveryAddress);
    });
});
