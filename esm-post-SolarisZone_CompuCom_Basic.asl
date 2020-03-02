/*
 * Location: /opt/InCharge9/ESM/smarts/local/conf/esm/esm-post-SolarisZone_CompuCom_Basic.asl
 * Purpose:  discovery post processing
 */

delim="\t";

AgentName="spl1002ncm.asdlab.local";

/* Create a handle to the SNMP Agent object */
agentObj=object(AgentName);

/* Test that the results are not null */
if (agentObj->isNull() ) {
        print("***********Error in esm-post-SolarisZone_CompuCom_Basic.asl********");
        stop();
}


/* DEBUG= TRUE; */

/* Get a handle to the actual device by using the getSystem
operation available through the agent object handle */

nodeObj=agentObj->getSystem();
print("SolarisZoneNODE_DLR_Class:".nodeObj->DisplayClassName);
print("SolarisZoneNODE_DLR_SystemName:".nodeObj->SystemName);


START {
    SOLARISZONE_FILE             // Get list of Solaris Zone hosts and client VMs from $SiteMod/conf/SolarisZone.conf

}

SOLARISZONE_FILE {

delim="\t";

   {
        SolarisZoneHost:rep(word) fs
        Container1:rep(word) ..eol}

do {
        print("SolarisZoneHost - ".SolarisZoneHost);
        print("Container1  -  ".Container1);
        if nodeObj->SystemName == SolarisZoneHost) {
          print("found SolarisZoneHost match - ".SolarisZoneHost."and will now insert container ".Container1);
        nodeObj->Contains += Container1;
        }
    }
//nodeObj->HostsVMs += Container1;
}

DEFAULT {
  ..eol
}
do {
     print("Failed match");
}



/*
 * These variables describe the formatting of this file. If you don't like the
 * template defaults, feel free to change them here (not in your .emacs file).
 *
 * Local Variables:
 * mode: C++
 * End:
 */

