pragma solidity ^0.8.0;

import "./UserOperation.sol";
import "./interfaces/Safe.sol";
import "./EIP4337Module.sol";

contract Custom4337Module is EIP4337Module {
    event Foo1Event(address indexed parameter);
    event Foo2Event(int256 indexed parameter);
    event Foo3Event(string parameter);

    constructor(address entryPoint, bytes4[] memory executionFunctionIds)
        EIP4337Module(entryPoint, executionFunctionIds)
    {
        for (uint256 i = 0; i < executionFunctionIds.length; i++) {
            supportedExecutionFunctionIds[executionFunctionIds[i]] = true;
        }
    }


    function foo1(address _addressParam) external {
        emit Foo1Event(_addressParam);
    }

    function foo2(int256 _intParam) external {
        emit Foo2Event(_intParam);
    }

    function foo3(string calldata _stringParam) external {
        emit Foo3Event(_stringParam);
    }
}

contract DeployCustomModule {
    Custom4337Module public customModule;

    constructor(address entryPoint) {
        customModule = new Custom4337Module(
            entryPoint,
            [
                bytes4(keccak256("foo1(address)")),
                bytes4(keccak256("foo2(int256)")),
                bytes4(keccak256("foo3(string)"))
            ]
        );
    }
}
