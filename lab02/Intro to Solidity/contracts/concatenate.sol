pragma solidity 0.4.19;


contract Concatenate {
    // transaction cost 26383 gas
    // execution cost 3447 gas
    function concatWithoutImport(string _s, string _t) public returns (string) {
        bytes memory sBytes = bytes(_s);
        bytes memory tBytes = bytes(_t);

        uint length1 = sBytes.length;
        uint length2 = tBytes.length;
        uint lengthTotal = length1 + length2;

        bytes memory result = new bytes(lengthTotal);
        for (uint i = 0; i < length1; i++) {
            result[i] = sBytes[i];
        }

        for (uint j = 0; j < length2; j++) {
            result[j+length1] = tBytes[j];
        }

        return string(result);
    }
}
