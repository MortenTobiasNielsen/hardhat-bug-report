// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Token1 {
    bytes4 private constant TRANSFERFROM = 0x23b872dd; // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));

    address private constant TOKEN2 =
        0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512; // This is not the correct address and should be replaced before the contract is deployed

    constructor() {}

    function interactWithToken2(uint256 amount) external {
        require(amount > 0, "The amount has to be larger than zero");
        (bool success, bytes memory data) =
            TOKEN2.call(
                abi.encodeWithSelector(
                    TRANSFERFROM,
                    msg.sender,
                    address(this),
                    amount
                )
            );
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            "Transfer failed"
        );
    }
}
