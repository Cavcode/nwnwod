void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

CreateItemOnObject("bloodvampire", oPC);

    ExecuteScript("fvex_area_inside",OBJECT_SELF);//Fallen's Vampires
}
