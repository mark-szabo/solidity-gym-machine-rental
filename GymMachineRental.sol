pragma solidity ^0.4.21;

contract GymMachineRental {

    event NewReservation(uint24 slotId, address client);

    uint constant slotTime = 30 minutes;

    // <contract_variables>
    uint pricePerSlot; //in wei
    address owner; //owner/contract creator address
    uint contractCreated; //timestamp of the contract
    address[] reservations; //array of reservations
    // </contract_variables>

    constructor(uint256 _pricePerSlot) public {
        pricePerSlot = _pricePerSlot;
        owner = msg.sender;
        contractCreated = now;
    }

    function reserve(uint24 _slotId) public payable {
        // Check if slot is free
        if (reservations[_slotId] != 0) revert();

        // Check for ether
        if (msg.value < pricePerSlot) revert();

        // Reserve slot
        reservations[_slotId] = msg.sender;

        // Trigger event
        emit NewReservation(_slotId, msg.sender);
    }

    function validate(address _client) public view returns (bool) {
        // Calculate current slot
        uint24 currentSlot = uint24((now - contractCreated) % slotTime);

        // Check wether the client has reserved this slot
        return reservations[currentSlot] == _client;
    }

    function withdraw() public {
        // Authorize owner
        if (msg.sender != owner) return;

        // Recover funds on the contract
        selfdestruct(owner);
    }

}
