const FoodDelivery = artifacts.require("./FoodDelivery.sol");
const Restaurants = artifacts.require("./Restaurants.sol");
const Customers = artifacts.require("./Customers.sol");
const Orders = artifacts.require("./Orders.sol");

module.exports = function(deployer) {
	deployer.deploy(Restaurants)
	.then(() => {
		return deployer.deploy(Customers);
	})
	.then(() => {
		console.log("Customers contract deployed at", Customers.address);
		return deployer.deploy(Orders, Restaurants.address, Customers.address);
	})
	.then(() => {
		return deployer.deploy(FoodDelivery, Restaurants.address, Customers.address, Orders.address);
	});
};
