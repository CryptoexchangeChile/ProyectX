pragma solidity ^0.4.0;

contract AddressRegisterAbstract{
    
       //Estado de issues
       mapping(address => bool) public issueState;
       //ID de direccion
       mapping(address =>uint ) public addressID;
       //Tipos de cuenta:
       //0: Usuario NO Registrado
       //1: Usuario Registrado
       //2: Usuario Baneado
       mapping(address=> uint) public accountType;
       //Fecha de Registro
       mapping(address=> uint) public registerDate;
       
       
    
}

contract AddressRegisterData is AddressRegisterAbstract{
    
    uint public accountNumber;
    address public collaborumAddress = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c ;
    
    constructor() public {
        
        collaborumAddress = msg.sender;
        addressID[collaborumAddress] = 1;
        registerDate[collaborumAddress] = now;
        accountType[collaborumAddress] = 3;
        issueState[collaborumAddress] = false;
        
        
        accountNumber++;
        
    }
        
                //FILTRA PARA QUE SOLO LLAME EL CREADOR    
                modifier onlyCollaborum{
                require(collaborumAddress==msg.sender);
                _;
                }
                
                modifier onlyUnregistered(address _userAddress){
                    require(addressID[_userAddress]==0);
                    _;
                }
                
                function registerAddress(address _userAddress) public 
                onlyCollaborum
                onlyUnregistered(_userAddress){
                      
                      registerDate[_userAddress] = now;
                      accountNumber++;
                      addressID[_userAddress] = accountNumber;
                      issueState[_userAddress] = false;
                      accountType[_userAddress] = 1;
                      
                    }
                
                    
            
                function banUser(address _userAddress) public
                onlyCollaborum{
                      accountType[_userAddress] = 2; 
                }    
                /*
                function purgeIssue() public 
                onlyCollaborum{
                    
                }
                function invokeIssue() public
                onlyCollaborum{
                    
                }*/
    
}