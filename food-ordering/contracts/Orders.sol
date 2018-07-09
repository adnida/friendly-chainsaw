pragma solidity ^0.4.18;

contract Orders {
    Restaurants restaurants;
    Customers customers;
    uint orderseq;

    constructor(address restaurantsContractAddress, address customersContractAddress) public {
        restaurants = Restaurants(restaurantsContractAddress);
        customers = Customers(customersContractAddress);
        orderseq = 0;
    }

    enum OrderStatus { Ordered, Prepared, Delivered, Cancelled }

    struct Order {
        address customer;
        address restaurant;
        uint[] menuItems;
        uint[] quantities;
        OrderStatus status;
        uint lastUpdated;

        bool isOrder;
    }

    mapping(uint => Order) public orders;
    mapping(address => Order[]) public customerOrders;
    mapping(address => Order[]) public restaurantOrders;

    event OrderSubmittedEvent(address customer, address restaurant, uint orderId);
    event OrderUpdatedEvent(uint orderId);

    function submitOrder(address restaurant, uint[] menuItems, uint[] quantities) public {
        require (customers.checkIsCustomer(msg.sender));
        require (restaurants.checkIsRestaurant(restaurant));

        Order memory order = Order({
            customer: msg.sender,
            restaurant: restaurant,
            quantities: quantities,
            status: OrderStatus.Ordered,
            menuItems: menuItems,
            lastUpdated: now,
            isOrder: true
        });

        uint orderId = ++orderseq;

        orders[orderId] = order;
        customerOrders[msg.sender][customerOrders[msg.sender].length] = order;
        restaurantOrders[restaurant][restaurantOrders[restaurant].length] = order;
        emit OrderSubmittedEvent(msg.sender, restaurant, orderId);
    }

    function checkIsOrder(uint orderId) public view returns (bool) {
        return orders[orderId].isOrder;
    }

    function getOrder(uint orderId) public view returns (
        address customer,
        address restaurant,
        uint[] menuItems,
        uint[] quantities,
        uint status,
        uint lastUpdated
    ) {
        require(checkIsOrder(orderId));
        return(
            orders[orderId].customer,
            orders[orderId].restaurant,
            orders[orderId].menuItems,
            orders[orderId].quantities,
            uint(orders[orderId].status),
            orders[orderId].lastUpdated
        );
    }
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
