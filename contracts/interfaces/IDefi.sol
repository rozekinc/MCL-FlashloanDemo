pragma solidity >=0.6.0 <0.8.0;

interface IDefi {
    function depositBNB(uint256 _amount) external payable;

    function withdraw(uint256 _amount) external;
}
