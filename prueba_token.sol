
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

/// @custom:security-contact daolabb@gmail.com
contract TestToken1 is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit, ERC20Votes {


  // Definición de Variables
  uint8 token_compra; // variable que toma la cantidad de tokens asignados al validar la entrega
  string status; // Variable que detalla el estatus del usuario (Principiante, Propulsor y Embajador)
  uint256 public total_token; // Acumulado de tokens por address
  uint256 private constant PESOS_POR_TOKEN = 10000; // Constante para el valor en pesos por token

  constructor(address initialOwner)
        ERC20("trustify-prueba", "TRUSPRUEBA")
        Ownable(initialOwner)
        ERC20Permit("trustify-prueba")
    {}

    function asignarTokensPorCompra(address usuario, uint256 valorCompra) public onlyOwner {
        require(valorCompra > 0, "El valor de la compra debe ser mayor a 0");
 
        // Calcular la cantidad de tokens a asignar (1 token por cada 10000 pesos)
        uint8 tokensAAsignar = uint8(valorCompra / PESOS_POR_TOKEN);
 
        require(tokensAAsignar > 0, "El valor de la compra es insuficiente para recibir tokens");
 
        // Mintear los nuevos tokens al usuario
        _mint(usuario, tokensAAsignar);

        // Actualizar las variables
         token_compra = tokensAAsignar;
        total_token += tokensAAsignar; //Acumular los tokens
     }

  // Función simple para consultar el total de tokens de un usuario
    function obtenerTokensUsuario(address usuario) public view returns (uint256) {
        return balanceOf(usuario);  // Usa la función balanceOf de ERC20
    }

  // Funciones heredadas y existentes...
    function pause() public onlyOwner {
      _pause(); 
    }

    function unpause() public onlyOwner {
     _unpause();
    }

  function clock() public view override returns (uint48) {
    return uint48(block.timestamp);
  }

  function CLOCK_MODE() public pure override returns (string memory) {
    return "mode=timestamp";
  }

  function _update(address from, address to, uint256 value)
   internal
    override(ERC20, ERC20Pausable, ERC20Votes)
  {
    super._update(from, to, value);
  }

    function nonces(address owner)
        public
        view
          override(ERC20Permit, Nonces)
         returns (uint256)
  {
    return super.nonces(owner);
  }
}