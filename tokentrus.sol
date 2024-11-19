// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Importamos la implementación estándar del ERC20 de OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

    contract trustify is ERC20, Ownable,ERC20Permit {
    // Constructor para inicializar el token
       /* constructor(string memory Trustify, string memory TRUS) ERC20(Trustify,TRUS)
        // Opcional: Mint inicial al propietario
        _mint(msg.sender, 1000 * 10 ** decimals()); // 1000 tokens iniciales
        {} */

        constructor(address initialOwner)
            ERC20("trustify", "TRUS")
            Ownable(initialOwner)
            ERC20Permit("trustify")
            // Opcional: Mint inicial al propietario
        {   
            _mint(msg.sender, 1000 * 10 ** decimals());
        } 

    // Función para asignar tokens (mint) a un nuevo usuario
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}