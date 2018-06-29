pragma solidity 0.4.19;


contract Greeter {
    string private greeting;

    function Greeter(string _greeting) public {
      greeting = _greeting;
    }

    function greet() public view returns (string) {
      return greeting;
    }
}
