# solidity-gym-machine-rental

Homework in Solidity for the Blockchain Technologies and Applications course of Budapest University of Technology and Economics

## Table of contents

* [Problem statement](#problem-statement)
* [Example scenario](#example-scenario)
* [Contract interface](#contract-interface)
* [Contract skeleton](#contract-skeleton)
* [Remix test logs](#remix-test-logs)

## Problem statement

Implement a smart contract for gym machine rental.

* The contract should have exactly one owner (the gym's management).
* Clients can buy access to machines in the gym for time slots of 30 minutes.
* The owner sets the price per time slot.
* Anyone can check whether a client has access to the machine at any given time.
* The owner can withdraw the profits.

## Example scenario

Alice owns a gym. She creates an instance of this contract to manage access to one of the popular machines in her gym, setting the price per time slot to 0.005 ether.

Bob reserves the time slot between 11:00am and 11:30am this Sunday using the time slot's number since contract creation. After 11:00am he scans the QR code of his Ethereum address on the machine. The machine checks if he has access and unlocks.

## Contract interface

* constructor: `function GymMachineRental(uint256 pricePerSlot)`
  * The creator of the contract (`msg.sender`) is the owner.
  * `pricePerSlot` is the price for renting the machine for a single time slot.
* reserve: `function reserve(uint24 slotId) payable`
  * Reserve the slotId'th time slot since contract creation. For example, if the contract was created today at 00:00, then slot number 16 would be the one from 07:30 to 08:00, while slot number 64 would be the same time slot on the next day.
  * This transaction succeeds only if the time slot has not yet been reserved, and the sender transfers the correct amount of ether.
* validate: `function validate(address client) view returns (bool)`
  * Returns true if client is entitled to use the machine at the time of the validation.
  * Can be called by anyone. (In our use case, this will be called by the machine itself.)
* withdraw: `function withdraw()`

  * Transfer profit to the sender.
  * Only the owner of the contract can call this method.

## Contract skeleton

```solidity
pragma solidity ^0.4.21;

contract GymMachineRental {

    event NewReservation(uint24 slotId, address client);

    uint constant slotTime = 30 minutes;

    struct Reservation {
        uint24 slotId;
        address client;
    }

    uint pricePerSlot;
    address owner;
    uint contractCreated;
    Reservation[] reservations;

    constructor(uint256 _pricePerSlot) public {}

    function reserve(uint24 _slotId) public payable {}

    function validate(address _client) public view returns (bool) {}

    function withdraw() public {}

}
```

## Remix test logs

```
creation of GymMachineRental pending...
[vm] from:0xca3...a733c, to:GymMachineRental.(constructor), value:0 wei, data:0x608...00005, 0 logs, hash:0x5cb...766bd
Details
 status 	0x1 Transaction mined and execution succeed
 contractAddress 	0x83be1f6e44a79014e1776835ce46acd00f035843
 from 	0xca35b7d915458ef540ade6068dfe2f44e8fa733c
 to 	GymMachineRental.(constructor)
 gas 	3000000 gas

 transaction cost 	464955 gas
 execution cost 	317659 gas
 hash 	0x5cb581a8e13018c0ec40958d55ebeef0d7b2c3cf724f03e2c4252e07af9766bd
 input 	0x608060405234801561001057600080fd5b506040516020806105c6833981018060405281019080805190602001909291905050508060008190555033600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055504260028190555060036040805190810160405280600062ffffff168152602001600073ffffffffffffffffffffffffffffffffffffffff1681525090806001815401808255809150509060018203906000526020600020016000909192909190915060008201518160000160006101000a81548162ffffff021916908362ffffff16021790555060208201518160000160036101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505050505061046a8061015c6000396000f300608060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063207c64fb1461005c5780633ccfd60b146100b7578063af762829146100ce575b600080fd5b34801561006857600080fd5b5061009d600480360381019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506100f3565b604051808215151515815260200191505060405180910390f35b3480156100c357600080fd5b506100cc6101f3565b005b6100f1600480360381019080803562ffffff16906020019092919050505061028c565b005b60008060006001610708600254420381151561010b57fe5b04019150600090505b6003805490508110156101e7578162ffffff1660038281548110151561013657fe5b9060005260206000200160000160009054906101000a900462ffffff1662ffffff161480156101cc57508373ffffffffffffffffffffffffffffffffffffffff1660038281548110151561018657fe5b9060005260206000200160000160039054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16145b156101da57600192506101ec565b8080600101915050610114565b600092505b5050919050565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614151561024f5761028a565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b565b60008090505b6003805490508110156102ee578162ffffff166003828154811015156102b457fe5b9060005260206000200160000160009054906101000a900462ffffff1662ffffff1614156102e157600080fd5b8080600101915050610292565b6000543410156102fd57600080fd5b600360408051908101604052808462ffffff1681526020013373ffffffffffffffffffffffffffffffffffffffff1681525090806001815401808255809150509060018203906000526020600020016000909192909190915060008201518160000160006101000a81548162ffffff021916908362ffffff16021790555060208201518160000160036101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505050507f46c4845c03cf25ad45b9e29f625cf88b40ee3cdfb14b7f0de6e844a69d9607ec8233604051808362ffffff1662ffffff1681526020018273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019250505060405180910390a150505600a165627a7a72305820f652f127b9add7123bc82ab0ec5153713dbc8fcc302d3e03dc6d4d50f9f8666400290000000000000000000000000000000000000000000000000000000000000005
 decoded input 	{
	"uint256 _pricePerSlot": "5"
 }
 decoded output 	 -
 logs 	[]
 value 	0 wei

transact to GymMachineRental.reserve pending ...
[vm] from:0xca3...a733c, to:GymMachineRental.reserve(uint24) 0x83b...35843, value:5 wei, data:0xaf7...00002, 1 logs, hash:0xb32...bd114
Details
 status 	0x1 Transaction mined and execution succeed
 from 	0xca35b7d915458ef540ade6068dfe2f44e8fa733c
 to 	GymMachineRental.reserve(uint24) 0x83be1f6e44a79014e1776835ce46acd00f035843
 gas 	3000000 gas

 transaction cost 	55369 gas
 execution cost 	33905 gas
 hash 	0xb32bfc33cc4330bc5803c2aaad89e501cce80e090abe5fd5b8680f16663bd114
 input 	0xaf7628290000000000000000000000000000000000000000000000000000000000000002
 decoded input 	{
	"uint24 _slotId": "2"
 }
 decoded output 	{}
 logs 	[
	{
		"topic": "46c4845c03cf25ad45b9e29f625cf88b40ee3cdfb14b7f0de6e844a69d9607ec",
		"event": "NewReservation",
		"args": [
			"2",
			"0xca35b7d915458ef540ade6068dfe2f44e8fa733c"
		]
	}
 ]
 value 	5 wei

call to GymMachineRental.validate
[call] from:0xca35b7d915458ef540ade6068dfe2f44e8fa733c, to:GymMachineRental.validate(address), data:207c6...a733c, return:
Details
 {
	"0": "bool: false"
 }

transact to GymMachineRental.reserve pending ...
[vm] from:0xca3...a733c, to:GymMachineRental.reserve(uint24) 0x83b...35843, value:5 wei, data:0xaf7...00001, 1 logs, hash:0xede...bb28f
Details
 status 	0x1 Transaction mined and execution succeed
 from 	0xca35b7d915458ef540ade6068dfe2f44e8fa733c
 to 	GymMachineRental.reserve(uint24) 0x83be1f6e44a79014e1776835ce46acd00f035843
 gas 	3000000 gas

 transaction cost 	56199 gas
 execution cost 	34735 gas
 hash 	0xede14ee59e90920a45748bba2ea21df40514c51ea2f9885a3ae04d31038bb28f
 input 	0xaf7628290000000000000000000000000000000000000000000000000000000000000001
 decoded input 	{
	"uint24 _slotId": "1"
 }
 decoded output 	{}
 logs 	[
	{
		"topic": "46c4845c03cf25ad45b9e29f625cf88b40ee3cdfb14b7f0de6e844a69d9607ec",
		"event": "NewReservation",
		"args": [
			"1",
			"0xca35b7d915458ef540ade6068dfe2f44e8fa733c"
		]
	}
 ]
 value 	5 wei

call to GymMachineRental.validate
[call] from:0xca35b7d915458ef540ade6068dfe2f44e8fa733c, to:GymMachineRental.validate(address), data:207c6...a733c, return:
Details
 {
	"0": "bool: true"
 }

transact to GymMachineRental.withdraw pending ...
[vm] from:0xca3...a733c, to:GymMachineRental.withdraw() 0x83b...35843, value:0 wei, data:0x3cc...fd60b, 0 logs, hash:0x756...331aa
Details
 status 	0x1 Transaction mined and execution succeed
 from 	0xca35b7d915458ef540ade6068dfe2f44e8fa733c
 to 	GymMachineRental.withdraw() 0x83be1f6e44a79014e1776835ce46acd00f035843
 gas 	3000000 gas

 transaction cost 	13470 gas
 execution cost 	5667 gas
 hash 	0x75623f0c9f81b0bab36d77f795a6649558626d46ca59e1adb87ce0ff9e8331aa
 input 	0x3ccfd60b
 decoded input 	{}
 decoded output 	{}
 logs 	[]
 value 	0 wei
```

## Copyright

Copyright (c) 2018 Mark Szabo, Balazs Bodo. All rights reserved.
