pragma solidity ^0.8.4;

contract BEP20Standard {
 
  mapping (address => uint256) public balances;

  mapping (address => mapping (address => uint256)) public allowances;

  uint256 public totalSupply = 1000000 * 10 ** 18; // 1 million;
  uint8 public decimals = 18;
  string public symbol = "TTCN";
  string public name = "Tito Coin";

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  constructor() {
    balances[msg.sender] = totalSupply; // It assigns totalSupply to the contract deployer

    emit Transfer(address(0), msg.sender, totalSupply);
  }

  function balanceOf(address account) public view returns (uint256) {
    return balances[account];
  } 

  function transfer(address recipient, uint256 amount) public returns (bool) {
    require(msg.sender != address(0), "BEP20: transfer from the zero address");
    require(recipient != address(0), "BEP20: transfer to the zero address");
    require(balanceOf(msg.sender) >= amount, 'Balance too low');

    balances[msg.sender] -= amount;
    balances[recipient] += amount;
    emit Transfer(msg.sender, recipient, amount);
   
    return true;
  }

  function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
    require (balanceOf(sender) >= amount, 'Balance too low');
    require (allowances[sender][msg.sender] >= amount, 'Allowance too low');

    balances[sender] -= amount;
    balances[recipient] += amount;
    emit Transfer(sender, recipient, amount);
    return true;
  }

  function approve(address spender, uint256 amount) public returns (bool) {
    require(msg.sender != address(0), "BEP20: approve from the zero address");
    require(spender != address(0), "BEP20: approve to the zero address");

    allowances[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);

    return true;
  }
}
