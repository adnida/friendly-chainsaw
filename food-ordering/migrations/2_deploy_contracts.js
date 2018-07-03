const FoodDelivery = artifacts.require("./FoodDelivery.sol");
const Restaurants = artifacts.require("./Restaurants.sol");
const Customers = artifacts.require("./Customers.sol");

module.exports = function(deployer) {
	deployer.deploy(FoodDelivery);
	deployer.deploy(Restaurants);
	deployer.deploy(Customers);
};
