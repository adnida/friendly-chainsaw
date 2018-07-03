const FoodDelivery = artifacts.require("./FoodDelivery.sol");
const Restaurants = artifacts.require("./Restaurants.sol");

module.exports = function(deployer) {
	deployer.deploy(FoodDelivery);
	deployer.deploy(Restaurants);
};
