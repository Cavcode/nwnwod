////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_speedtoken
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  SetCustomToken(6664,FloatToString(GetLocalFloat(GetPCSpeaker(),"ORM_SPEED")));
  return TRUE;
}