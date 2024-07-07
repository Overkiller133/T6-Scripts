#include maps\mp\gametypes_zm\_hud;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm_utility;

// ToDo:
/*  
    - make code scalable!!!!!!
    
    - add maximum zombies per round counter - get_round_enemy_array();
    - add ammo counter
*/

/*
    name:   initHUD
    desc:   define array to store data
    para:   N/A
*/
initHUD()
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    // Array HUD-Elements - used to display text
    HUDElement = [];
    HUDElement[0] = "Health";
    HUDElement[1] = "Zombies";

    // Arrays Counter & Maximum - used to store values
    Counter = [];
    Maximum = [];

    for ( i = 0; i < HUDElement.size; i++)
    {
        Counter[HUDElement[i]] = 0;
        Maximum[HUDElement[i]] = 0;
    }

    self drawHUD( HUDElement, Counter, Maximum );
}

/*
    name:   drawHUD
    desc:   uses the arrays to create and draw the HUD
    para:   HUD-Element (stores text for HUD), Counter (store current values for HUD), Maximum (store maximum values for HUD)
*/
drawHUD( HUDElement, Counter, Maximum )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
 
    for ( i = 0; i < HUDElement.size; i++ )
    {
        self.HUDElement[i] = self createFontString( "Font", 1.5 );
        self.HUDElement[i] setPoint( "BOTTOM_LEFT", "BOTTOM_LEFT", -45, -55 - ( i * 25) );
        self.HUDElement[i] setText( HUDElement[i] + ": " + Counter[i] + " / " + Maximum[i] );
        self.HUDElement[i].foreground = true;
        self.HUDElement[i].hideWhenInMenu = true;
        self.HUDElement[i].alpha = 1;
    }

    self thread getData( HUDElement, Counter, Maximum );
}

/*
    name:   getData
    desc:   get data and store it in array
    para:   HUD-Element (stores text for HUD), Counter (store current values for HUD), Maximum (store maximum values for HUD)
*/
getData( HUDElement, Counter, Maximum )
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for(;;)
    {
        
        // Health Counter
        self.Counter[0] = self.health;
        self.Maximum[0] = self.maxhealth;

        if ( !isDefined( self.oldPlayerHealth ) )
        {
            self.oldPlayerHealth = self.Counter[0];
            self updateData( HUDElement, self.Counter, self.Maximum, 0 );
        }
        else
        {
            if ( self.oldPlayerHealth != self.Counter[0])
            {
                self.oldPlayerHealth = self.Counter[0];
                self updateData( HUDElement, self.Counter, self.Maximum, 0 );
            }
        }

        // Zombie Counter
        self.Counter[1] = get_current_zombie_count();

        if ( !isDefined( self.oldZombieCount ) )
        {
            self.oldZombieCount = self.Counter[1]; 
            self updateData( HUDElement, self.Counter, self.Maximum, 1 );
        }
        else
        {
            if ( self.oldZombieCount != self.Counter[1] )
            {
                self.oldZombieCount = self.Counter[1];
                self updateData( HUDElement, self.Counter, self.Maximum, 1 );
            }
        }

        wait(0.2);
    }
}

/*
    name:   updateData
    desc:   update menu with values stored in array
    para:   HUD-Element (stores text for HUD), Counter (store current values for HUD), Maximum (store maximum values for HUD)
*/
updateData( HUDElement, Counter, Maximum, ArrayIndex )
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    switch(ArrayIndex)
    {
        case 0:
            self.prefix = " / " + self.Maximum[ArrayIndex];
            break;
        case 1:
            self.prefix = "";
            break;
        default:
            break;
    }

    self.HUDElement[ArrayIndex] setText( HUDElement[ArrayIndex] + ": " + self.Counter[ArrayIndex] + self.prefix ); 
}