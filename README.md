# CalorieCoin GYM contracts
![Tron-Badge](https://img.shields.io/badge/-TRON-red?style=flat&color=404040&logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/PjwhRE9DVFlQRSBzdmcgIFBVQkxJQyAnLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4nICAnaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkJz48c3ZnIGhlaWdodD0iMzJweCIgaWQ9Il94M0NfTGF5ZXJfeDNFXyIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgMzIgMzI7IiB2ZXJzaW9uPSIxLjEiIHZpZXdCb3g9IjAgMCAzMiAzMiIgd2lkdGg9IjMycHgiIHhtbDpzcGFjZT0icHJlc2VydmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+CjwhW0NEQVRBWwoJLnN0MHtmaWxsOiNFM0YyRkQ7fQoJLnN0MXtmaWxsOiM4MEQ4RkY7fQoJLnN0MntmaWxsOiMxQUQyQTQ7fQoJLnN0M3tmaWxsOiNFQ0VGRjE7fQoJLnN0NHtmaWxsOiM1NUZCOUI7fQoJLnN0NXtmaWxsOiNCQkRFRkI7fQoJLnN0NntmaWxsOiNDMUFFRTE7fQoJLnN0N3tmaWxsOiNGRjUyNTI7fQoJLnN0OHtmaWxsOiNGRjhBODA7fQoJLnN0OXtmaWxsOiNGRkI3NEQ7fQoJLnN0MTB7ZmlsbDojRkZGMTc2O30KCS5zdDExe2ZpbGw6I0ZGRkZGRjt9Cgkuc3QxMntmaWxsOiM2NUM3RUE7fQoJLnN0MTN7ZmlsbDojQ0ZEOERDO30KCS5zdDE0e2ZpbGw6IzM3NDc0Rjt9Cgkuc3QxNXtmaWxsOiM3ODkwOUM7fQoJLnN0MTZ7ZmlsbDojNDJBNUY1O30KCS5zdDE3e2ZpbGw6IzQ1NUE2NDt9Cl1dPgo8L3N0eWxlPjxnIGlkPSJUcm9uX3gyQ19fY3J5cHRvIj48ZyBpZD0iWE1MSURfMTQwXyI+PGNpcmNsZSBjbGFzcz0ic3Q3IiBjeD0iMTYiIGN5PSIxNiIgaWQ9IlhNTElEXzIyXyIgcj0iMTQuNSIvPjwvZz48ZyBpZD0iWE1MSURfMTI4XyI+PGcgaWQ9IlhNTElEXzEzOF8iPjxwYXRoIGNsYXNzPSJzdDE3IiBkPSJNMTYsMzFDNy43MywzMSwxLDI0LjI3LDEsMTZTNy43MywxLDE2LDFzMTUsNi43MywxNSwxNVMyNC4yNywzMSwxNiwzMXogTTE2LDIgICAgIEM4LjI4LDIsMiw4LjI4LDIsMTZzNi4yOCwxNCwxNCwxNHMxNC02LjI4LDE0LTE0UzIzLjcyLDIsMTYsMnoiIGlkPSJYTUxJRF83NTBfIi8+PC9nPjxnIGlkPSJYTUxJRF84MV8iPjxnIGlkPSJYTUxJRF8xMTlfIj48cGF0aCBjbGFzcz0ic3QxMSIgZD0iTTE3LDE1LjNjLTAuMjQsMC0wLjQ2LTAuMTgtMC40OS0wLjQzYy0wLjA0LTAuMjcsMC4xNS0wLjUzLDAuNDItMC41N2w4LjUtMS4yNiAgICAgIGMwLjI3LTAuMDMsMC41MywwLjE1LDAuNTcsMC40MmMwLjA0LDAuMjctMC4xNSwwLjUzLTAuNDIsMC41N2wtOC41LDEuMjZDMTcuMDUsMTUuMjksMTcuMDIsMTUuMywxNywxNS4zeiIgaWQ9IlhNTElEXzc0OV8iLz48L2c+PGcgaWQ9IlhNTElEXzExOF8iPjxwYXRoIGNsYXNzPSJzdDExIiBkPSJNMTcsMTUuM2MtMC4xMSwwLTAuMjItMC4wNC0wLjMyLTAuMTFsLTguNS02LjkzYy0wLjIxLTAuMTctMC4yNS0wLjQ5LTAuMDctMC43ICAgICAgYzAuMTgtMC4yMSwwLjQ5LTAuMjUsMC43LTAuMDdsOC41LDYuOTNjMC4yMSwwLjE3LDAuMjUsMC40OSwwLjA3LDAuN0MxNy4yOSwxNS4yMywxNy4xNSwxNS4zLDE3LDE1LjN6IiBpZD0iWE1MSURfNzQ4XyIvPjwvZz48ZyBpZD0iWE1MSURfMTE3XyI+PHBhdGggY2xhc3M9InN0MTEiIGQ9Ik0xNS40MywyNi42M2MtMC4wMiwwLTAuMDUsMC0wLjA3LDBjLTAuMjctMC4wNC0wLjQ2LTAuMjktMC40My0wLjU2bDEuNTctMTEuMzMgICAgICBjMC4wMi0wLjEyLDAuMDgtMC4yMywwLjE3LTAuMzFsNS4xNi00LjUzYzAuMjEtMC4xOCwwLjUyLTAuMTYsMC43MSwwLjA1YzAuMTgsMC4yMSwwLjE2LDAuNTItMC4wNSwwLjcxbC01LjAyLDQuNDFMMTUuOTIsMjYuMiAgICAgIEMxNS44OSwyNi40NSwxNS42NywyNi42MywxNS40MywyNi42M3oiIGlkPSJYTUxJRF83NDdfIi8+PC9nPjxnIGlkPSJYTUxJRF8xMTZfIj48cGF0aCBjbGFzcz0ic3QxMSIgZD0iTTE1LjQzLDI2LjYzYy0wLjAzLDAtMC4wNSwwLTAuMDgtMC4wMWMtMC4xOC0wLjAzLTAuMzMtMC4xNS0wLjM5LTAuMzJMOC4wMyw4LjA1ICAgICAgQzcuOTcsNy44OCw4LDcuNjksOC4xMSw3LjU1YzAuMTEtMC4xNCwwLjMtMC4yLDAuNDctMC4xN2wxMy42NiwyLjM5YzAuMSwwLjAyLDAuMTksMC4wNiwwLjI2LDAuMTRsMy4zNCwzLjI3ICAgICAgYzAuMTgsMC4xOCwwLjIsMC40NywwLjA0LDAuNjdMMTUuODIsMjYuNDRDMTUuNzIsMjYuNTYsMTUuNTgsMjYuNjMsMTUuNDMsMjYuNjN6IE05LjI4LDguNTFsNi4zLDE2LjYybDkuMjQtMTEuNTZsLTIuOS0yLjg1ICAgICAgTDkuMjgsOC41MXoiIGlkPSJYTUxJRF83NDRfIi8+PC9nPjwvZz48L2c+PC9nPjwvc3ZnPg==) ![Typescript-Badge](https://img.shields.io/badge/Typescript-white?&logo=typescript) ![Solidity-Badge](https://img.shields.io/badge/Solidity-v0.8.20-404040?&logo=solidity)


This project for our `CalorieCoin` Team's eco-system contracts.  
## Summary
### CalroieCoin Token (TRC20)
+ Base of teams eco-system tokenomics
+ Burnable
+ Permit
+ Non-Pause
### Badge (TRC721)
### Application (for GYM Class)
### Attendance (for GYM Class)
### Order
### Membership
### Heart-Rate(or Burned Calorie Rate) based Reward Program

## TRON Mainnet Contract Deployer Address
+ [TVt6FVhL9uTVoCrV8PQi3vWvP2TUBZPwFX](https://tronscan.org/#/address/TVt6FVhL9uTVoCrV8PQi3vWvP2TUBZPwFX)

## Deployed Contracts Address
After if contracts are deployed, contract's address will be write in here 😘
### CalroieCoin Token & Token Proxy Contract Address
#### Testnet(Nile) Contract Address
+ Token `Proxy`: [TZ9GHDzCCWWMYUcmQiaityderjkm5PP4gb](https://nile.tronscan.org/#/contract/TZ9GHDzCCWWMYUcmQiaityderjkm5PP4gb) 
    - Hex: 41fe31ca2207bb6ce58952974beaf20ef9bc1a11f2
+ TRC20 `CalorieCoin`: [TPpb7SRg9eP9G7MoJeHeGSAda4JponLT97](https://nile.tronscan.org/#/token20/TPpb7SRg9eP9G7MoJeHeGSAda4JponLT97)  
    - Hex: 4197f0794c23123cd12d0c8f10ebbbe92de171b98f
#### Mainnet Contract Address
+ Token `Proxy`: [TRZuVTXsjUxUL8VG8pH8pVVTVjFDjHvaVS](https://tronscan.org/#/contract/TRZuVTXsjUxUL8VG8pH8pVVTVjFDjHvaVS)
+ TRC20 `CalorieCoin`: [TJZgFyVsWaK8A1cy35XkBr5br1NCLUk71c](https://tronscan.org/#/token20/TJZgFyVsWaK8A1cy35XkBr5br1NCLUk71c)
### Membership
#### Testnet(Nile) Contract Address
+ `Membership` : [TKszFkFisdB7K5P4yqp3LnymhAY7PRrykM](https://nile.tronscan.org/#/contract/TKszFkFisdB7K5P4yqp3LnymhAY7PRrykM)
    - Hex: 416cb4899dd2a7ceb14bc1502dbc97ff0e448b9464
#### Mainnet Contract Address
+ `Membership` : [TGwZWWgGzeatpPCVj7mZHRX8aBpRjnYMpU](https://tronscan.org/#/contract/TGwZWWgGzeatpPCVj7mZHRX8aBpRjnYMpU)
### Badge
#### Testnet(Nile) Contract Address
+ TRC721 `Badge`: badge will be create by `BadgeFactory` contract
+ `BadgeFactory`: [TQim8YNTxEVPS7ukozzPbVbaFNGPbPaBxZ](https://nile.tronscan.org/#/contract/TQim8YNTxEVPS7ukozzPbVbaFNGPbPaBxZ)
    - Hex: 41a1ce779f8af4ba8add5c21484264e42c9d7c5a66
#### Mainnet Contract Address
+ TRC721 `Badge`: -
+ `BadgeFactory`: [TRgpJLjCjyiUvnQMgqux4F5dPBzBJbsmW3](https://tronscan.org/#/contract/TRgpJLjCjyiUvnQMgqux4F5dPBzBJbsmW3)
### Application
#### Testnet(Nile) Contract Address
+ `Application`: -
#### Mainnet Contract Address
+ `Application`: -
### Attendance
#### Testnet(Nile) Contract Address
+ `Attendance`: [TTFQDLNa8tSvE7hTryaoudN1WrzQgDfBh2](https://nile.tronscan.org/#/contract/TTFQDLNa8tSvE7hTryaoudN1WrzQgDfBh2)
#### Mainnet Contract Address
+ `Attendance`: [TEtKZXddogGnp46n7oEbELjp8op6roD18V](https://tronscan.org/#/contract/TEtKZXddogGnp46n7oEbELjp8op6roD18V)
### Order
#### Testnet(Nile) Contract Address
+ `Order`: [TRTFSGdvmYtwczQ9T2QhGrLSRWnJLQPjFQ](https://nile.tronscan.org/#/contract/TRTFSGdvmYtwczQ9T2QhGrLSRWnJLQPjFQ)
    - Hex: 41a9d790e8f9a7d99ad316235f889edb89bd025903
#### Mainnet Contract Address
+ `Order`: [TBdsgkYU1RQM5qwYEAa39ALY82Zbt53s34](https://tronscan.org/#/contract/TBdsgkYU1RQM5qwYEAa39ALY82Zbt53s34)

## Build
And you can build contracts with `hardhat`

```shell
# example compile commands
npx hardhat compile
```

## Hackathon List
### Tron Hackathon Season 2
**TronDAO Forum Link**  
https://forum.trondao.org/t/caloriecoin-e2e-jumpgame-e2e-excercise-to-earn-smart-jump-rope-game-caloriecoin/5280

### Tron Hackathon Season 7
**TronDAO Forum Link**   
https://forum.trondao.org/t/caloriecoin-gym-tronics-see-you-again-after-2022-hackathon/26524
