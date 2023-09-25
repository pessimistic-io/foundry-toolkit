// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Reentrant {
    mapping(address => uint256) public balances;

    function deposit() external payable {
    	balances[msg.sender] += msg.value;
    }

    function withdraw() external {
    	uint256 amount = balances[msg.sender];
    	if (amount == 0) {
    		return;
    	}
    	(bool success, ) = msg.sender.call{value: amount}("");
    	// require(success);
    	balances[msg.sender] = 0;
    }
}
