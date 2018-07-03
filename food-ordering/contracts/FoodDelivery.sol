pragma solidity ^0.4.18;

contract FoodDelivery {
    event FoodOrderedEvent();
    event FoodDispatchedEvent();
    event OrderCancelledEvent();
    event PaymentAcceptedEvent();

    bool public foodDispatched;

    function orderFood() public payable {}

    function dispatchFood() public pure {}

    function acceptPayment() public pure {}

    function cancelOrder() public view {
        require (!foodDispatched);
    }
}
