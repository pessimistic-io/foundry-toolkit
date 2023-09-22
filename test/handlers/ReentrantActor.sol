pragma solidity ^0.8.13;

import {console2} from "forge-std/console2.sol";
import {ReentrantCallStorage} from "./ReentrantCallStorage.sol";


contract ReentrantActor {
	ReentrantCallStorage private _callStorage;

	constructor(ReentrantCallStorage callStorage) {
		_callStorage = callStorage;
	}

	fallback() external payable {
        bytes memory storedCall = _callStorage.getStoredCall();
        if (storedCall.length == 0) {
        	return;
        }
        console2.log("reentering");
        console2.logBytes(storedCall);
        (bool success, ) = msg.sender.call(storedCall);
    }
}