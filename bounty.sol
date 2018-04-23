pragma solidity ^0.4.0;

             // ¯\_(ツ)_/¯//           // ¯\_(ツ)_/¯//
            //           // _(͡ ͜ʖ͡° )_/¯//           //
           // ¯\_(ツ)_/¯//           // ¯\_(ツ)_/¯//
          /* Proyecto Collaborum BountyHunt
                                   Smart-Contract*/
                                   
  //Test Adresses
         //#1. Collaborum Address 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
         //#2. Creator Contract Address 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c
         //#3. Pre-selected Hunter 1 0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db
         //#4. Pre-selected Hunter 2 0x583031d1113ad414f02576bd6afabfb302140225
         //#5. Pre-selected Hunter 3 0xdd870fa1b7c4700f2bd7f44238821c26f7392148
         
    //Default Amount 10 ether = 10000000000000000000 wei
    //Default Array ["0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db","0x583031d1113ad414f02576bd6afabfb302140225", "0xdd870fa1b7c4700f2bd7f44238821c26f7392148"]
                                   
contract BountyAbstract{
    
    //Creador del Contrato    
    address public owner;
  
    //Cazadores Pre-seleccionados
    address[]public preselectedList;
    
    //Cazador Elegido
    address public hunter;
    
    //Collaborum GOD
    address public collaborum = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    
    //Monto a Pagar  
    uint public payAmount;
    
    //Fecha Inicio
    uint public initDate;
    
    //Fecha Limite
    uint public maxDate;
    
    //Balance Billetera Actual
    uint public accountBalance;
    
    //Boolean Consulta Issues
    bool public noIssue = true;
    
    //Estado de Contrato
    uint public state = 0;
    
    string public fileHash;
    
    
      
        //FILTRA PARA QUE SOLO LLAME EL CREADOR    
        modifier onlyOwner{
        require(owner==msg.sender);
        _;
        } 
         //FILTRA PARA QUE SOLO LLAME EL CREADOR    
        modifier onlyHunter{
        require(hunter==msg.sender);
        _;
        } 
        
        //FILTRA ESTADO DE CONTRATO == 0 //CONTRATO INICIALIZADO
         modifier onlyStateZero{
        require(state==0);
        _;
        } 
        
        //FILTRA ESTADO DE CONTRATO == 1 //CONTRATO CONFIRMADO
         modifier onlyStateOne{
        require(state==1);
        _;
        }
          //FILTRA ESTADO DE CONTRATO == 1 //CONTRATO CONFIRMADO
         modifier onlyStateTwo{
        require(state==2);
        _;
        }
          //FILTRA ESTADO DE CONTRATO == 1 //CONTRATO CONFIRMADO
         modifier onlyStateThree{
        require(state==3);
        _;
        }
        
        
        //FILTRO QUE ASEGURA SI SE HA PAGADO LA CANTIAD DECLARADA
         modifier onlyPayed{
        require(accountBalance == payAmount);
        _;
        } 
        
        modifier onlyRegistered{
            //require(accountBalance == payAmount);
            _;
        }
        //CERTIFICADO DE QUE NO HAY RECLAMOS O BLOQUEOS EN LA BILLETERA
        modifier noIssuesCertificate{
        /* //Consulta en en BountyData    
         if(searchForIssue()==true)
            noIssue=false;
            
         else noIssue=true;
            
            if(noIssue==true){
                //transfer to Collaborum
                collaborum.transfer(payAmount);
            }
            
            else*/
            require(noIssue==true);
            _;
            
        }
            //NOTIFICA DEL CAMBIO DE ESTADO
            event ChangedState (uint a);
            //
            /*
            function searchForIssue() pure
            private 
            returns(bool){
                
                return false;
            }*/
            
            
                //Settea el Hunter desde al lista de Hunters Preseleccionados
                //Requiere haberse confirmado el Monto
                //*OnlyInPreselected
                function setHunter(address _hunter) public 
                onlyOwner 
                onlyStateOne{
                    hunter = _hunter;
                    
                }
                //Settea el monto a pagar
                function setPayAmount(uint _payAmount) public
                onlyOwner 
                onlyStateZero{
                    payAmount = _payAmount;
                }
                //Confirma el Monto a Pagar
                //Pasa de State 0 to 1
                   function confirmPayAmount() public
                onlyOwner 
                onlyStateZero{
                    state = 1;
                    emit ChangedState(state);
                    
                }
                //Confirma Permanentemente al Hunter  
                    function lockHunter() public
                    onlyOwner
                    onlyStateOne
                    onlyRegistered{
                        state = 2;
                        emit ChangedState(state);
                    }
                    
                //Una Vez accountBalance > payAmount
                function triggerBountyHunt() public 
                onlyOwner
                onlyStateTwo
                onlyPayed{
                    state = 3;
                    emit ChangedState(state);
                }
                
                function confirmService() public
                onlyOwner
                onlyStateThree
                noIssuesCertificate{
                    state = 4;
                    emit ChangedState(state);
                    //DELAY
                   if(noIssue=true)
                    hunter.transfer(payAmount);
                   else
                   collaborum.transfer(payAmount);
                }
                
                function registerHunterIssue() public{
                    noIssue = false;
                }
                
                  function registerSheriffIssue() public{
                    noIssue = false;
                }
                
             
               
              
            
}

contract BountyHunt is BountyAbstract{
     
     
        //Setteamos la Address de los Hunters Pre-seleccionados 
        //y el Monto a Pagar
        constructor(address[] _hunters, uint _payAmount) public payable
        {   
            preselectedList = _hunters;
            payAmount = _payAmount;
            owner=msg.sender;
            initDate = now;
            //maxDate = getMaxDateUint();
            accountBalance = msg.value;
        }
        
     
}



// Primer trigger lockear hunter del grupo 
// 2do tirrger confirmas hash archivo. 
// Agregar cooldown antes de enviar.
// 5 Horas, Consultar si hay issues .
// Clbt, cherif, hunter.
// Hash al ser descifrado = link al archivo.
// Resolucion Querella.




