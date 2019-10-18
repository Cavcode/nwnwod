#include "toy_source"
//Chastity Belt
void main()
{
    //Get stored data
    string sToyTag = GetLocalString(OBJECT_SELF, "MR_TOY_TAG");
    string sToyName = GetLocalString(OBJECT_SELF, "MR_TOY_NAME");
    object oToyOwner = GetLocalObject(OBJECT_SELF, "MR_TOY_OWNER");

    //Get the names of the two players
    string sTargetName = GetName(OBJECT_SELF);
    string sOwnerName = GetName(oToyOwner);

    int nToyInUse = GetLocalInt(OBJECT_SELF, sToyTag);

    //Determine what clothing model number to use
        int nAppearance;
    switch (GetGender(OBJECT_SELF)) {
        case GENDER_FEMALE : nAppearance = BDSM_NUMBER_CHASTITY_F; break;
        case GENDER_MALE : nAppearance = BDSM_NUMBER_CHASTITY_M; break; }

    //Removal messages
    string sSpeak1 = sOwnerName + " removes a chastity belt from the waist of " + sTargetName;
    string sOwnerMessage1 = "You remove the chastity belt from the waist of " + sTargetName;
    string sTargetMessage1 = sOwnerName + " removes the chastity belt from your waist.";

    //Add messages " + sTargetName;
    string sSpeak2 = sOwnerName + " secures a chastity belt around the waist of " + sTargetName;
    string sOwnerMessage2 = "You secure a chastity belt around the waist of " + sTargetName;
    string sTargetMessage2 = sOwnerName + " secures a chastity belt around your waist.";

    //Get the targets clothing
    object oChest = GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF);
    object oModified;
    object oModified2;

    if (nToyInUse) {
        //Reset the clothing to 0
        oModified = CopyItemAndModify(oChest, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_PELVIS, 0);
        //Equip the new clothing
        DelayCommand(0.8, AssignCommand(OBJECT_SELF, ActionEquipItem(oModified, INVENTORY_SLOT_CHEST)));
        //Destroy the old clothing
        DelayCommand(1.3, DestroyObject(oChest));
        //Send the appropiate messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage1);
            SendMessageToPC(oToyOwner, sOwnerMessage1); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak1));
        //Clear the flag
        DeleteLocalInt(OBJECT_SELF, sToyTag); }

    if (!nToyInUse) {
        //Alter the clothing
        oModified = CopyItemAndModify(oChest, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_PELVIS, nAppearance);
        //Equip the new clothing
        DelayCommand(0.8, AssignCommand(OBJECT_SELF, ActionEquipItem(oModified, INVENTORY_SLOT_CHEST)));
        //Destroy the old clothing
        DelayCommand(1.3, DestroyObject(oChest));
        //Send the appropraite messages
        if (EMOTE_STRINGS_OFF) {
            SendMessageToPC(OBJECT_SELF, sTargetMessage2);
            SendMessageToPC(oToyOwner, sOwnerMessage2); }
        if (!EMOTE_STRINGS_OFF) AssignCommand(oToyOwner, SpeakString(sSpeak2));
        //Set the flag
        SetLocalInt(OBJECT_SELF, sToyTag, 1); }

    DeleteLocalString(OBJECT_SELF, "MR_TOY_TAG");
    DeleteLocalString(OBJECT_SELF, "MR_TOY_NAME");
    DeleteLocalObject(OBJECT_SELF, "MR_TOY_OWNER");


}