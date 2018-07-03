pragma solidity ^0.4.18;


contract Customers {
    struct Customer {
        string deliveryAddress;
    }

    mapping (address => Customer) public customers;
    event CustomerRegisteredEvent(address customerAddress, string deliveryAddress);

    function registerAsCustomer(string deliveryAddress) public {
        customers[msg.sender].deliveryAddress = deliveryAddress;
        emit CustomerRegisteredEvent(msg.sender, deliveryAddress);
    }
}
