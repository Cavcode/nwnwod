////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Appearance Changing
//  ocr_cnv_lhand
//  By Don Anderson
//  dandersonru@msn.com
//
//  Remake Armor - Set Left Hand
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
  object oPC = GetPCSpeaker();
  SetLocalInt(oPC, "CR_PART", ITEM_APPR_ARMOR_MODEL_LHAND);
}