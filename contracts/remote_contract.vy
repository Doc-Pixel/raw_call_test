# @version >=0.3.6

operators:  public(HashMap[address, HashMap[address,bool]])

event Approved:
    owner: address
    operator: address
    approved: bool

@nonpayable
@external
def setApprovalForAll(operator:address, approved: bool):
    self.operators[msg.sender][operator] = approved
    log Approved(msg.sender, operator, approved)

@external
def isApprovedForAll(owner: address, operator: address) -> bool:
    return self.operators[owner][operator]
