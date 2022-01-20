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

    //Returns the amount of token the delegate is allowed to transfer in name of the owner
    function allowance(address _owner, address _spender) external view returns(uint256);

    //Returns boolean value as a result of the operation
    function transfer(address _recipient, uint256 _amount) external returns(bool);

    //Returns boolean value as a result of the spending operation
    function approve(address _spender, uint256 amount) external returns(bool);

    //Returns boolean value as a result of the tokens exchange operation using allowance() method
    function transferFrom(address _sender, address _recipient, uint256 _amount) external returns(bool);

    //Event emitted when a given amount of tokens is transferred
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //Event emitted when the allowance() method is called 
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

/*
    TO DO: Restrict increaseTotalSupply to smart contract owner
*/

contract ERC20Token is IERC20{

    using SafeMath for uint256;

    //Declarations
    string public constant name = "ERC20-AngelGC";
    string public constant symbol = "AGC";
    uint8 public constant decimals = 2; //To use with Binance Smart Chain - Testnet. Add this amount of 0 to the desired totalSupply_ of constructor

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    uint256 totalSupply_;

    //Events
    event Transfer(address indexed _from, address indexed _to, uint256 _tokens);
    event Approval(address indexed _owner, address indexed _spender, uint256 _tokens);

    //Constructor and initialization
    constructor(uint256 _initialSupply) public{
        totalSupply_ = _initialSupply;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns(uint256){
        return totalSupply_;
    }

    function increaseTotalSupply(uint _newTokensAmount) public{
        totalSupply_ += _newTokensAmount;
        balances[msg.sender] += _newTokensAmount;
    }

    function balanceOf(address _tokenOwner) public override view returns (uint256){
        return balances[_tokenOwner];
    }

    function allowance(address _owner, address _delegate) public override view returns(uint256){
        return allowed[_owner][_delegate];
    }

    function transfer(address _recipient, uint256 _tokensAmount) public override returns(bool){
        require(_tokensAmount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(_tokensAmount);
        balances[_recipient] = balances[_recipient].add(_tokensAmount);
        emit Transfer(msg.sender, _recipient, _tokensAmount);
        return true;
    }

    function approve(address _delegate, uint256 _tokensAmount) public override returns(bool){
        allowed[msg.sender][_delegate] = _tokensAmount;
        emit Approval(msg.sender, _delegate, _tokensAmount);
        return true;
    }
    
    function transferFrom(address _owner, address _buyer, uint256 _tokensAmount) public override returns(bool){
        require(_tokensAmount <= balances[_owner], "Not enough tokens in owner account");
        require(_tokensAmount <= allowed[_owner][msg.sender], "Not enough tokens in delegate account");

        balances[_owner] = balances[_owner].sub(_tokensAmount);
        allowed[_owner][msg.sender] = allowed[_owner][msg.sender].sub(_tokensAmount);
        balances[_buyer] = balances[_buyer].add(_tokensAmount);

        emit Transfer(_owner, _buyer, _tokensAmount);

        return true;
    }
}