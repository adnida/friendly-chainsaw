pragma solidity ^0.4.18;

contract FoodDelivery {
    Restaurants restaurants;
    Customers customers;
    Orders orders;

    event FoodOrderedEvent();
    event FoodDispatchedEvent();
    event OrderCancelledEvent();
    event PaymentAcceptedEvent();

    constructor(
        address restaurantsContractAddress,
        address customersContractAddress,
        address ordersContractAddress) public {
        restaurants = Restaurants(restaurantsContractAddress);
        customers = Customers(customersContractAddress);
        orders = Orders(ordersContractAddress);
    }

    struct Shipment {
        address courier;
        uint price;
        uint date;

        bool isShipment;
    }

    function orderFood(
        address restaurant,
        uint[] menuItems,
        uint[] quantities
    ) public payable {
        uint totalPrice = getTotalOrderPrice(restaurant, menuItems, quantities);
        require(restaurants.checkIsRestaurant(restaurant), "Restaurant not found");
        require(msg.value >= totalPrice, "Unsufficient value");

        orders.submitOrder(restaurant, menuItems, quantities);
        emit FoodOrderedEvent();
    }

    function getTotalOrderPrice(address restaurant, uint[] menuItems, uint[] quantities) internal view returns (uint) {
        // calculate price
        uint totalPrice = 0;
        for (uint i = 0; i < menuItems.length; i++) {
            string memory name;
            uint itemPrice;
            (name, itemPrice) = restaurants.getMenuItem(restaurant, menuItems[i]);
            totalPrice += itemPrice * quantities[i];
        }
        return totalPrice;
    }

    function dispatchFood() public pure {}

    function cancelOrder() public pure {}
}

contract Restaurants {
    function checkIsRestaurant(address _address) public pure returns (bool) { _address; }
    function getRestaurant(address _address) public pure returns (string, string) { _address; }
    function getMenuItem(address _address, uint index) public pure returns (string, uint) { _address; index; }
}

contract Customers {
    function registerAsCustomer(string deliveryAddress) public pure { deliveryAddress; }
    function checkIsCustomer(address _address) public pure returns (bool) { _address; }
}

contract Orders {
    function submitOrder(address restaurant, uint[] menuItems, uint[] quantities) public pure { restaurant; menuItems; quantities; }
    function checkIsOrder(uint orderId) public pure returns (bool) { orderId; }
    function getOrder(uint orderId) public pure returns (
        address,address, uint[], uint[], uint, uint
    ) { orderId; }
}
