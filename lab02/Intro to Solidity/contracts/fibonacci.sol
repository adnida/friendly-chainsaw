pragma solidity 0.4.19;


contract Fibonacci {
    /* Carry out calculations to find the nth Fibonacci number */
    function fibRecur(uint n) public pure returns (uint) {
        if (n < 2) {
            return n;
        }

        return fibRecur(n - 1) + fibRecur(n - 2);
    }

    /* Carry out calculations to find the nth Fibonacci number */
    function fibIter(uint n) public pure returns (uint) {
        uint lo = 0;
        uint hi = 1;

        for (uint i = 0; i < n; i++) {
          hi = lo + hi;
          lo = hi - lo;
        }

        return lo;
    }
}
