pragma solidity ^0.4.18;

contract Orders {
    Restaurants restaurants;
    Customers customers;

    constructor(address restaurantsContractAddress, address customersContractAddress) public {
        restaurants = Restaurants(restaurantsContractAddress);
        customers = Customers(customersContractAddress);
    }

    enum OrderStatus { Ordered, Prepared, Delivered, Cancelled }

    struct Order {
        uint uuid;
        address customer;
        address restaurant;
        uint[] menuItems;
        uint[] quantities;
        OrderStatus status;
        uint lastUpdated;
        bool isOrder;
    }

    mapping(address => Order[]) public customerOrders;
    mapping(address => Order[]) public restaurantOrders;

    event OrderSubmittedEvent(address customer, address restaurant, uint uuid);
    event OrderUpdatedEvent(uint uuid);

    function submitOrder(uint uuid, address restaurant, uint[] menuItems, uint[] quantities) public {
        require (customers.checkIsCustomer(msg.sender));
        require (restaurants.checkIsRestaurant(restaurant));

        Order memory order = Order({
            uuid: uuid,
            customer: msg.sender,
            restaurant: restaurant,
            quantities: quantities,
            status: OrderStatus.Ordered,
            menuItems: menuItems,
            lastUpdated: now,
            isOrder: true
        });

        customerOrders[msg.sender][customerOrders[msg.sender].length] = order;
        restaurantOrders[restaurant][restaurantOrders[restaurant].length] = order;
        emit OrderSubmittedEvent(msg.sender, restaurant, uuid);
    }
}

contract Restaurants {
    function checkIsRestaurant(address _address) public pure returns (bool) {}
    function getRestaurant(address _address) public pure returns (string, string) {}
    function getMenuItem(address _address, uint index) public pure returns (string, uint) {}
}

contract Customers {
    function checkIsCustomer(address _address) public pure returns (bool) {}
}
