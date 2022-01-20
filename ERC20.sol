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

    //Returns boolean value as a result of the operation
    function transfer(address _recipient, uint256 _amount) external returns(bool);

    //Returns boolean value as a result of the spending operation
    function approve(address _spender, uint256 amount) external returns(bool);

    //Returns boolean value as a result of the tokens exchange operation using allowance() method
    function transferFrom(address _sender, address _recipient, uint256 _amount) external returns(bool);

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

    function transfer(address _recipient, uint256 _amount) public override returns(bool){
        return false;
    }

    function approve(address _spender, uint256 amount) public override returns(bool){
        return false;
    }
    
    function transferFrom(address _sender, address _recipient, uint256 _amount) public override returns(bool){
        return false;
    }
}