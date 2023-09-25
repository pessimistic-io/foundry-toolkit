pragma solidity ^0.8.13;

import {AddressSet, LibAddressSet} from "../helpers/AddressSet.sol";
import {ReentrantCallStorage} from "./ReentrantCallStorage.sol";
import {ReentrantActor} from "./ReentrantActor.sol";


contract BaseActorHandler {
	using LibAddressSet for AddressSet;
    AddressSet internal _actors;
    address internal currentActor;

    ReentrantCallStorage private _callStorage;
    uint256 constant REENTRANT_ACTOR_PROBABILITY_PERCENT = 50;

    constructor(address payable callStorage) {
        _callStorage = ReentrantCallStorage(callStorage);
    }

    modifier createActor() {
        ReentrantActor actor = new ReentrantActor(_callStorage);
        currentActor = address(actor);
        _actors.add(address(actor));
        _;
    }

    modifier useActor(uint256 actorIndexSeed) {
        currentActor = _actors.rand(actorIndexSeed);
        _;
    }
}