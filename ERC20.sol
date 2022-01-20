// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;
import "./SafeMath.sol";

//ERC20 token interface
interface IERC20{
    //Returns amount of existing tokens
    function totalSupply() external view returns(uint256);

    //Returns amount of tokens for a given address
    function balanceOf(address _account) external view returns (uint256);

    //Returns the amount of token the spender is allowed to spend in the name of the owner
    function allowance(address _owner, address _spender) external view returns(uint256);


}

contract ERC20Token is IERC20{

    function totalSupply() public override view returns(uint256){
        return 0;
    }

    function balanceOf(address _account) public override view returns (uint256){
        return 0;
    }

    function allowance(address _owner, address _spender) public override view returns(uint256){
        return 0;
    }

}