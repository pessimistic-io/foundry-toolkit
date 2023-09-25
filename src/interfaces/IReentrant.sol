pragma solidity ^0.8.13;


interface IReentrant {
	function deposit() external payable;
	function withdraw() external;
}