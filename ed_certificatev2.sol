// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * la idea del codigo es que:
 * 1. solo el dueño del contrato pueda mintear tokens (NFT) y asignarselos a una address en particular
 * 2. todos las imagenes son guardadas en el mismo repositorio (baseURI)
 * 3. previamente hay que cargar el json y las imagenes
 * 4. A un usuario se le da la oportunidad de ver cuantos tokens tiene y cuales son.
 */
contract edCertificate is ERC721Enumerable, Ownable {

    using Strings for uint256;
    
    string private _baseURIString;
    mapping(uint256 => string) private _tokenURIs;


    constructor(string memory baseURI_) ERC721("Educational Certificate", "EDC") public {
        
        _baseURIString = baseURI_;
    }

    function mint (address owner) public onlyOwner returns(uint256 tokenId) {
        uint256 tokenId = totalSupply() + 1;
        string memory _tokenURI = string(abi.encodePacked(_baseURIString, tokenId.toString()));
        _safeMint (owner, tokenId);        
        _setTokenURI(tokenId, _tokenURI);
        return tokenId;
    }
    
    /**
     * Hago un override porque la función de ERC721 hace 'return "";'
     */
     
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIString;
    }

    function baseURI() public view virtual returns (string memory) {
        return _baseURI();
    }
    
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }
    
    function setBaseURI(string memory baseURIAux_) public onlyOwner {
        _baseURIString = baseURIAux_;
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual onlyOwner {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _setTokenURI(tokenId, _tokenURI);
    }


}