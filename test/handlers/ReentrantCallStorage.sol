pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
// import {console2} from "forge-std/console2.sol";


contract ReentrantCallStorage is Test {

    bytes private _storedCall;

    modifier storeCall() {
        console2.log("storing call");
        console2.logBytes(msg.data[:4]);
        _storedCall = msg.data;
        _;
    }

    function getStoredCall() external view returns(bytes memory) {
        return _storedCall;
    }

    fallback() external storeCall {}
    receive() external payable storeCall {}

    // function deposit() external payable storeCall {
    // }

    // function withdraw() external storeCall {
    // }
}