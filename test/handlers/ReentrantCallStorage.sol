pragma solidity ^0.8.13;

import {console2} from "forge-std/console2.sol";


contract ReentrantCallStorage {

    bytes private _storedCall;

    modifier storeCall() {
        console2.log("storing call");
        _storedCall = msg.data;
        _;
    }

    function getStoredCall() external view returns(bytes memory) {
        return _storedCall;
    }

    function deposit() external payable storeCall {
    }

    function withdraw() external storeCall {
    }
}