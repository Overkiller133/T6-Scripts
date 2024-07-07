//////////////////////////////////////////
//      OVK_HUD.gsc                     //
//--------------------------------------//
//		Version: 1.2		            //
//		Includes: OVK_HUD\*             //
//      Description: A custom HUD       //
//      Features:   - Health HUD        // 
//                  - Zombie Counter    //
//////////////////////////////////////////

// CoD imports
#include common_scripts\utility;
#include maps\mp\_utility;

// My imports
#include scripts\zm\OVK_HUD\hud;

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );  

        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    self initHUD(); // start HUD
}