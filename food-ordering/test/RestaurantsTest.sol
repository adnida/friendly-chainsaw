pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Restaurants.sol";

contract RestaurantsTest {
    Restaurants instance = Restaurants(DeployedAddresses.Restaurants());

    function testRegisterRestaurant() public {
        address _address;
        string memory name;
        string memory businessAddress;

        string memory expectedName = "Restaurant One";
        string memory expectedBusinessAddress = "One Marina Boulevard, Singapore";

        (_address, name, businessAddress) = instance.registerAsRestaurant(expectedName, expectedBusinessAddress);
        (name, businessAddress) = instance.getRestaurant(_address);

        Assert.equal(name, expectedName, "Name does not match");
        Assert.equal(businessAddress, expectedBusinessAddress, "Business address does not match");
    }
}
