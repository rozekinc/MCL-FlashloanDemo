pragma solidity >=0.6.0 <0.8.0;

// SPDX-License-Identifier: The MIT License

/**
 * @title IFlashLoanReceiver interface
 * @notice Interface for the Multiplier fee IFlashLoanReceiver.
 * @author Multiplier Finance
 * @dev implement this interface to develop a flashloan-compatible
 * flashLoanReceiver contract
 **/
interface IFlashLoanReceiver {
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    ) external;
}
