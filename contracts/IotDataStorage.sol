// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract IotDataStorage {
    struct Data {
        bytes32 hash;
    }

    mapping (uint256 => Data) private dataStore;

    event DataStored(uint256 indexed id, bytes32 hash);

    struct IoTData {
        string timestamp;
        string device_id;
        string sensor_type;
        string value;
        string unit;
    }
    
    // This is simpily storing of data in the blockchain or we can say signing of data in cryptographic term.
    function storeData(uint256 id, string memory device_id, string memory sensor_type, string memory value, string memory unit) public {
    uint256 timestamp = block.timestamp;
    bytes32 hash = keccak256(abi.encodePacked(timestamp, device_id, sensor_type, value, unit));
    dataStore[id] = Data(hash);
    emit DataStored(id, hash);
}

   // This is basically retrieving of data or chcking and verfication of data that data hash not been altered.
    function retrieveData(uint256 id, IoTData memory data) public view returns (bool) {
        bytes32 hash = keccak256(abi.encodePacked(data.timestamp, data.device_id, data.sensor_type, data.value, data.unit));
        return dataStore[id].hash == hash;
    }
}