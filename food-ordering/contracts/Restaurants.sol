pragma solidity ^0.4.18;

contract Restaurants {
    struct MenuItem {
        string name;
        uint price;
        bool isActive;
        bool isMenuItem;
    }

    struct Restaurant {
        string name;
        string businessAddress;
        bool isRestaurant;
    }

    mapping(address => Restaurant) public restaurants;
    mapping(address => MenuItem[]) public restaurantMenu;

    event RestaurantRegisteredEvent(address restaurantAddress, string name, string businessAddress);
    event MenuItemAddedEvent(address restaurantAddress, string name, uint price);

    function registerAsRestaurant(string name, string businessAddress) public returns (address, string, string) {
        restaurants[msg.sender].name = name;
        restaurants[msg.sender].businessAddress = businessAddress;
        restaurants[msg.sender].isRestaurant = true;

        emit RestaurantRegisteredEvent(msg.sender, restaurants[msg.sender].name, restaurants[msg.sender].businessAddress);
        return (msg.sender, restaurants[msg.sender].name, restaurants[msg.sender].businessAddress);
    }

    function getRestaurant(address _address) public view returns (string, string) {
        require(checkIsRestaurant(_address));

        string memory name = restaurants[_address].name;
        string memory businessAddress = restaurants[_address].businessAddress;

        return (name, businessAddress);
    }

    function checkIsRestaurant(address _address) public view returns (bool) {
        return restaurants[_address].isRestaurant;
    }

    function addMenuItem(string name, uint price) public {
        require(checkIsRestaurant(msg.sender));
        restaurantMenu[msg.sender].push(MenuItem(name, price, true, true));
        emit MenuItemAddedEvent(msg.sender, name, price);
    }

    function checkIsMenuItem(address restaurant, uint index) public view returns (bool) {
        return restaurantMenu[restaurant][index].isMenuItem;
    }

    function checkIsMenuItemActive(address restaurant, uint index) public view returns (bool) {
        return restaurantMenu[restaurant][index].isActive;
    }

    function getMenuItem(address _address, uint index) public view returns (string, uint) {
        require(checkIsRestaurant(_address), "Restaurant not found");
        require(checkIsMenuItem(_address, index), "Menu item not found");
        require(checkIsMenuItemActive(_address, index), "Menu item deleted");

        return (restaurantMenu[_address][index].name, restaurantMenu[_address][index].price);
    }
}
