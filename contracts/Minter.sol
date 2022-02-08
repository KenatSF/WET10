// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
pragma experimental ABIEncoderV2;

import { SafeMath } from '@openzeppelin/contracts/utils/math/SafeMath.sol';
import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface WETH10 {
  function flashLoan(
    address receiver,
    address token,
    uint value,
    bytes calldata data
  ) external returns (bool);
}

contract Minter {
  // WETH 10
  address private WETH = 0xf4BB2e28688e89fCcE3c0580D37d36A7672E8A9F;
  address private real_weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  bytes32 public immutable CALLBACK_SUCCESS = keccak256("ERC3156FlashBorrower.onFlashLoan");

  address public sender;
  address public token;

  event Log(string name, uint val);

  function flash(uint _amount) external {
    uint total = IERC20(WETH).totalSupply();
    // borrow more than available
    uint amount = total + _amount;

    emit Log("Actual total supply", total);

    IERC20(WETH).approve(WETH, amount);

    bytes memory data = "";
    WETH10(WETH).flashLoan(address(this), WETH, amount, data);
  }

  // called by WETH10
  function onFlashLoan(
    address _sender,
    address _token,
    uint amount,
    uint fee,
    bytes calldata data
  ) external returns (bytes32) {
    uint bal = IERC20(WETH).balanceOf(address(this));
    uint bal2 = IERC20(real_weth).balanceOf(address(this));

    sender = _sender;
    token = _token;

    emit Log("Amount to borrow: ", amount);
    emit Log("fee to pay: ", fee);
    emit Log("WETH10", bal);
    emit Log("WETH", bal2);

    return CALLBACK_SUCCESS;
  }
}
