pragma solidity >=0.6.0 <0.8.0;

// SPDX-License-Identifier: The MIT License

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/token/ERC20/SafeERC20.sol";
import "../interfaces/IFlashLoanReceiver.sol";
import "../interfaces/ILendingPoolAddressesProvider.sol";

abstract contract FlashLoanReceiverBase is IFlashLoanReceiver {
    using SafeERC20 for IERC20;
    using SafeMath for uint256;

    ILendingPoolAddressesProvider public addressesProvider;

    address public constant BNB_ADDRESS =
        0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    constructor(ILendingPoolAddressesProvider _provider) public {
        addressesProvider = _provider;
    }

    receive() external payable {}

    function transferFundsBackToPoolInternal(address _reserve, uint256 _amount)
        internal
    {
        address payable core = addressesProvider.getLendingPoolCore();
        transferInternal(core, _reserve, _amount);
    }

    function transferInternal(
        address payable _destination,
        address _reserve,
        uint256 _amount
    ) internal {
        if (_reserve == BNB_ADDRESS) {
            //solium-disable-next-line
            (bool sent, bytes memory data) =
                _destination.call.value(_amount).gas(50000)("");
            require(sent, "Unable to transferInternal");
            return;
        }
        IERC20(_reserve).safeTransfer(_destination, _amount);
    }

    function getBalanceInternal(address _target, address _reserve)
        internal
        view
        returns (uint256)
    {
        if (_reserve == BNB_ADDRESS) {
            return _target.balance;
        }
        return IERC20(_reserve).balanceOf(_target);
    }
}
