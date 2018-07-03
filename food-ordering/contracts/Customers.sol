pragma solidity ^0.4.18;


contract Customers {
    struct Customer {
        string deliveryAddress;
    }

    mapping (uint => Customer) customers;

    function addCustomer() {

    }
}
