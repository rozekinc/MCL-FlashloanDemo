pragma solidity >=0.6.0 <0.8.0;

// SPDX-License-Identifier: The MIT License

interface ILendingPool {
    function flashLoan(
        address _receiver,
        address _reserve,
        uint256 _amount,
        bytes calldata _params
    ) external;
}
