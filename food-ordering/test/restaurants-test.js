const Restaurants = artifacts.require("Restaurants");

contract("Restaurants", accounts => {
  const [account1, account2, account3] = accounts;
  let instance;

  it("can register as a restaurant", async () => {
    instance = await Restaurants.deployed();
    let expectedName = "Restaurant One";
    let expectedBusinessAddress = "One Marina Boulevard";

    await instance.registerAsRestaurant(expectedName, expectedBusinessAddress, { from: account1 });
    let restaurant = await instance.restaurants(account1);

    assert.equal(restaurant[0], expectedName);
    assert.equal(restaurant[1], expectedBusinessAddress);
  });

  it("can add a menu item for an existing restaurant", async () => {
    let expectedName = "Kung Pow Chicken";
    let expectedPrice = "12";

    let result = await instance.addMenuItem(expectedName, expectedPrice, { from: account1 });
    let menuItem = await instance.getMenuItem(account1, 0);

    assert.equal(menuItem[0], expectedName);
    assert.equal(menuItem[1], expectedPrice);
  });

  it("can validate a restaurant", async() => {
      assert(await instance.checkIsRestaurant(account1));
      assert.equal(await instance.checkIsRestaurant(account2), false);
  });
});
