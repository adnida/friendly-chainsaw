pragma solidity 0.4.19;


contract XOR {
    function xor(uint a, uint b) public pure returns (uint) {
        return a ^ b;
    }

    // assumption: strings are the same length
    // txn cost on js vm: 25463 gas
    // execution cost on js vm: 2655 gas
    function sxor(string a, string b) public returns (string) {
        bytes memory abytes = bytes(a);
        bytes memory bbytes = bytes(b);

        bytes memory str = new bytes(abytes.length);

        for (uint i = 0; i < abytes.length; i++) {
            // 48(dec) or 0x31 is ascii for "0"
            uint x = uint(abytes[i]) - 48;
            uint y = uint(bbytes[i]) - 48;
            str[i] = byte(x^y + 48);
        }
        string memory result = string(str);
        return result;
    }
}
