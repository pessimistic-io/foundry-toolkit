pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {Reentrant} from "../../src/Reentrant.sol";
import {ReentrantActor} from "./ReentrantActor.sol";
import {BaseActorHandler} from "./BaseActorHandler.sol";

contract ReentrantHandler is Test, BaseActorHandler {

    Reentrant private _reentrant;

    constructor(address reentrant, address callStorage) BaseActorHandler(callStorage) {
        _reentrant = Reentrant(reentrant);
        vm.deal(reentrant, 10 ether);
    }

    function deposit(uint96 amount) external createActor() {
        vm.deal(currentActor, amount);

        vm.prank(currentActor);
        _reentrant.deposit{value: amount}();
    }

    function withdraw(uint256 actorSeed) external useActor(actorSeed) {
        vm.prank(currentActor);
        _reentrant.withdraw();
    }
}
