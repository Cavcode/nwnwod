void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
)
   {

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

effect eEffect;

eEffect = EffectSkillIncrease(SKILL_LISTEN, 10);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectSkillIncrease(SKILL_SPOT, 10);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

}