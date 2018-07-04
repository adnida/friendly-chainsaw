pragma solidity ^0.4.18;


contract Customers {
    struct Customer {
        string deliveryAddress;
        bool isCustomer;
    }

    mapping (address => Customer) public customers;
    event CustomerRegisteredEvent(address customerAddress, string deliveryAddress);

    function registerAsCustomer(string deliveryAddress) public {
        customers[msg.sender].deliveryAddress = deliveryAddress;
        customers[msg.sender].isCustomer = true;
        emit CustomerRegisteredEvent(msg.sender, deliveryAddress);
    }

    function checkIsCustomer(address _address) public view returns (bool) {
        return customers[_address].isCustomer;
    }
}
