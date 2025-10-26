// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/v4.9.3/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/v4.9.3/contracts/proxy/utils/Initializable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/v4.9.3/contracts/access/OwnableUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/v4.9.3/contracts/security/ReentrancyGuardUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/utils/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/extensions/IERC20Metadata.sol";
interface ILendingPoolLike {
    function handleDeposit(address asset, address onBehalfOf, uint256 amount) external;
    function handleWithdraw(address asset, address to, uint256 amount) external;
}
contract AToken is Initializable, ERC20PermitUpgradeable, OwnableUpgradeable, ReentrancyGuardUpgradeable {
    using SafeERC20 for IERC20;
    address public underlying;
    address public pool;
    function initialize(a
        address _underlying,
        address _pool,
        string memory name_,
        string memory symbol_
    ) external initializer {
        __ERC20_init(name_, symbol_);
        __ERC20Permit_init(name_);
        __Ownable_init();
        __ReentrancyGuard_init();
        underlying = _underlying;
        pool = _pool;
    }
    modifier onlyPool() {
        require(msg.sender == pool, "CALLER_NOT_POOL");
        _;
    }
    function mint(address to, uint256 amount) external onlyPool {
        _mint(to, amount);
    }
    function burn(address from, uint256 amount) external onlyPool {
        _burn(from, amount);
    }
    // override decimals from ERC20Upgradeable - try to read decimals from underlying token
    function decimals() public view override returns (uint8) {
        // call external decimals() on the underlying token, fallback to 18 if it fails
        try IERC20Metadata(underlying).decimals() returns (uint8 d) {
            return d;
        } catch {
            return 18;
        }
    }
}