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
        (bool success, ) = msg.sender.call(storedCall);
    }
}