/*
 * Deactivate random time
 *
 * MvDunkelfels 2004-12-16
 */

#include "mvd_02_const"

void main()
{
    SetLocalInt( GetModule(), cMvD_02_sIsPCRandomTime, FALSE );
}