# solidity-gym-machine-rental
Homework in Solidity for the Blockchain Technologies and Applications course of Budapest University of Technology and Economics

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

    // <contract_variables>

    // </contract_variables>

    function GymMachineRental(uint256 pricePerSlot) public {
        // TODO
    }

    function reserve(uint24 slotId) public payable {
        // TODO
    }

    function validate(address client) public view returns (bool) {
        // TODO
    }

    function withdraw() public {
        // TODO
    }

}
```
