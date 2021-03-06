//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT4
/*
  Default OnConversation event handler for NPCs.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
// Modified for DM Voice work as well as vehicles by Forrestwolf for D20 Modern.

#include "nw_i0_generic"

void main()
{


    // * if petrified, jump out


    ExecuteScript("dmfi_voice_exe", OBJECT_SELF);


    if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF) == TRUE)
    {
        return;
    }

    // * If dead, exit directly.
    if (GetIsDead(OBJECT_SELF) == TRUE)
    {
        return;
    }

    // See if what we just 'heard' matches any of our
    // predefined patterns
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    if (nMatch == -1 && GetIsPC(oShouter) &&(GetLocalInt(GetModule(), "dmfi_AllMute") || GetLocalInt(OBJECT_SELF, "dmfi_Mute")))
    {
        SendMessageToAllDMs(GetName(oShouter) + " is trying to speak to a muted NPC, " + GetName(OBJECT_SELF) + ", in area " + GetName(GetArea(OBJECT_SELF)));
        SendMessageToPC(oShouter, "This NPC is muted. A DM will be here shortly.");
    }
     // No talking for moving vehicles
    if (GetLocalInt(OBJECT_SELF, "nMdrnVehicle")==1 && GetLocalInt(OBJECT_SELF, "nSpeed")>0)
        return;
    if (nMatch == -1 && !GetLocalInt(GetModule(), "dmfi_AllMute") && !GetLocalInt(OBJECT_SELF, "dmfi_Mute"))
    {
        // Not a match -- start an ordinary conversation
        if (GetLocalInt(OBJECT_SELF, "nMdrnVehicle")==1)
        {
            return;
            //ActionStartConversation(oShouter, "", TRUE, FALSE);
        }
        else if (GetCommandable(OBJECT_SELF))
        {
            ClearActions(CLEAR_NW_C2_DEFAULT4_29);
            if (GetCampaignInt("dmfi", "dmfi_AllMute")==0)
                //ActionStartConversation(oShouter, "", TRUE, FALSE);
                BeginConversation();
            else
            {
                if (GetLocalInt(GetModule(), "dmfi_NPCTimer")==0)
                {
                    SendMessageToAllDMs(GetName(oShouter)+" has tried to speak to "+GetName(OBJECT_SELF)+"; to speak as this NPC, start with #");
                    SetLocalObject(GetModule(), "hls_NPCControl" + "#", OBJECT_SELF);

                      SetLocalInt(GetModule(), "dmfi_NPCTimer", 1);
                    DelayCommand(10.0, SetLocalInt(GetModule(), "dmfi_NPCTimer", 0));
                }
                else
                    SendMessageToAllDMs(GetName(oShouter)+" has tried to speak to "+GetName(OBJECT_SELF));

            }
        }
        else
        // * July 31 2004
        // * If only charmed then allow conversation
        // * so you can have a better chance of convincing
        // * people of lowering prices
        if (GetHasEffect(EFFECT_TYPE_CHARMED) == TRUE)
        {
            ClearActions(CLEAR_NW_C2_DEFAULT4_29);
            BeginConversation();
        }
    }
    if (GetLocalInt(OBJECT_SELF, "nMdrnVehicle")==1)
        return;
    // Respond to shouts from friendly non-PCs only
    else if (GetIsObjectValid(oShouter)
               && !GetIsPC(oShouter)
               && GetIsFriend(oShouter))
    {
        object oIntruder = OBJECT_INVALID;
        // Determine the intruder if any
        if(nMatch == 4)
        {
            oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
        }
        else if (nMatch == 5)
        {
            oIntruder = GetLastHostileActor(oShouter);
            if(!GetIsObjectValid(oIntruder))
            {
                oIntruder = GetAttemptedAttackTarget();
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedSpellTarget();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = OBJECT_INVALID;
                    }
                }
            }
        }

        // Actually respond to the shout
        RespondToShout(oShouter, nMatch, oIntruder);
    }

    // Send the user-defined event if appropriate
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }
}
