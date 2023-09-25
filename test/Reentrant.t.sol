// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

import {Reentrant} from "../src/Reentrant.sol";
import {ReentrantHandler} from "./handlers/ReentrantHandler.sol";
import {ReentrantCallStorage} from "./handlers/ReentrantCallStorage.sol";

contract ReentrantTest is Test {
    Reentrant public reentrant;
    ReentrantHandler public reentrantHandler;

    function setUp() public {
        reentrant = new Reentrant();
        vm.deal(address(reentrant), 10 ether);
        excludeContract(address(reentrant));

        address payable reentrantCallStorage = _deployReentrantCallStorage();

        reentrantHandler = new ReentrantHandler(
            address(reentrant),
            reentrantCallStorage
        );
        bytes4[] memory selectors = new bytes4[](2);
        selectors[0] = reentrantHandler.deposit.selector;
        selectors[1] = reentrantHandler.withdraw.selector;
        targetSelector(FuzzSelector({
            addr: address(reentrantHandler),
            selectors: selectors
        }));
    }

    function _deployReentrantCallStorage() internal returns(address payable) {
        Reentrant reentrantToReplace = new Reentrant();
        deployCodeTo("./ReentrantCallStorage.sol", address(reentrantToReplace));
        return payable(address(reentrantToReplace));
    }

    function invariant_ethSupplyDidNotDecrease() public {
        uint256 reentrantBalance = address(reentrant).balance;
        assertGe(reentrantBalance, 10 ether);
    }
}
