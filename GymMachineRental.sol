pragma solidity ^0.4.21;

contract GymMachineRental {

    event NewReservation(uint24 slotId, address client);

    uint constant slotTime = 30 minutes;

    struct Reservation {
        uint24 slotId;
        address client;
    }

    // <contract_variables>
    uint pricePerSlot; //in wei
    address owner; //owner/contract creator address
    uint contractCreated; //timestamp of the contract
    Reservation[] reservations; //array of reservations
    // </contract_variables>

    constructor(uint256 _pricePerSlot) public {
        pricePerSlot = _pricePerSlot;
        owner = msg.sender;
        contractCreated = now;
        reservations.push(Reservation(0, 0));
    }

    function reserve(uint24 _slotId) public payable {
        // Check if slot is already reserved
        for (uint i = 0; i < reservations.length; i++) {
            if (reservations[i].slotId == _slotId) revert();
        }

        // Check for ether
        if (msg.value < pricePerSlot) revert();

        // Reserve slot
        reservations.push(Reservation(_slotId, msg.sender));

        // Trigger event
        emit NewReservation(_slotId, msg.sender);
    }

    function validate(address _client) public view returns (bool) {
        // Calculate current slot
        uint24 currentSlot = uint24((now - contractCreated) / slotTime) + 1;

        // Check wether the client has reserved this slot
        for (uint i = 0; i < reservations.length; i++) {
            if (reservations[i].slotId == currentSlot && reservations[i].client == _client) return true;
        }

        return false;
    }

    function withdraw() public {
        // Authorize owner
        if (msg.sender != owner) return;

        // Recover funds on the contract
        selfdestruct(owner);
    }

}
