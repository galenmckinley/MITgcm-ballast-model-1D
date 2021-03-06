C $Header: /u/gcmpack/MITgcm/verification/OpenAD/code_oad_all/openad_dumpAdjoint.F,v 1.2 2011/05/24 20:59:04 jmc Exp $
C $Name:  $

#include "PACKAGES_CONFIG.h"
#include "CPP_OPTIONS.h"
#ifdef ALLOW_OBCS
# include "OBCS_OPTIONS.h"
#endif
#ifdef ALLOW_SEAICE
# include "SEAICE_OPTIONS.h"
#endif
#ifdef ALLOW_GMREDI
# include "GMREDI_OPTIONS.h"
#endif

C start with a copy of THE_MAIN_LOOP
C and remove some the obvious extras
      SUBROUTINE openad_dumpAdjoint(myTime, myIter, myThid )
      IMPLICIT NONE

C     == Global variables ==
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"

c**************************************
#ifdef ALLOW_AUTODIFF_TAMC

c These includes are needed for 
c AD-checkpointing. 
c They provide the fields to be stored.

# include "GRID.h"
# include "DYNVARS.h"
# include "FFIELDS.h"
# include "EOS.h"
# include "GAD.h"
# ifdef ALLOW_CD_CODE
#  include "CD_CODE_VARS.h"
# endif
# ifdef ALLOW_PTRACERS
#  include "PTRACERS_SIZE.h"
#  include "PTRACERS.h"
# endif
# ifdef EXACT_CONSERV
#  include "SURFACE.h"
# endif
# ifdef ALLOW_OBCS
#  include "OBCS_PARAMS.h"
#  include "OBCS_GRID.h"
#  include "OBCS_FIELDS.h"
#  include "OBCS_SEAICE.h"
# endif
# ifdef ALLOW_EXF
#  include "EXF_FIELDS.h"
#  include "EXF_PARAM.h"
#  ifdef ALLOW_BULKFORMULAE
#   include "EXF_CONSTANTS.h"
#  endif
# endif /* ALLOW_EXF */
# ifdef ALLOW_SEAICE
#  include "SEAICE.h"
# endif
# ifdef ALLOW_EBM
#  include "EBM.h"
# endif
# ifdef ALLOW_KPP
#  include "KPP.h"
#  include "KPP_DIAGS.h"
#  include "KPP_PARAMS.h"
# endif
# ifdef ALLOW_DIVIDED_ADJOINT_MPI
#  include "mpif.h"
# endif

# include "tamc.h"
# include "ctrl.h"
# include "ctrl_dummy.h"
# include "cost.h"

#endif /* ALLOW_AUTODIFF_TAMC */

      INTEGER myThid 
      INTEGER myIter
      _RL     myTime

      double precision foo5(1-olx:snx+olx,1-oly:sny+oly,nr,nsx,nsy)
      double precision foo4(1-olx:snx+olx,1-oly:sny+oly,nsx,nsy)

      CHARACTER*(10) suff

      if (Mod(myiter,360).eq.0) then 
         WRITE(suff,'(I10.10)') myIter
         foo5=theta%d
         call write_fld_xyz_rl('adjtheta.',suff,foo5,myiter,1)
         foo5=salt%d
         call write_fld_xyz_rl('adjsalt.',suff,foo5,myiter,1)
         foo5=uvel%d
         call write_fld_xyz_rl('adjuvel.',suff,foo5,myiter,1)
         foo5=vvel%d
         call write_fld_xyz_rl('adjvvel.',suff,foo5,myiter,1)
         foo5=wvel%d
         call write_fld_xyz_rl('adjwvel.',suff,foo5,myiter,1)
         foo4=etan%d
         call write_fld_xy_rl('adjetan.',suff,foo4,myiter,1)
# ifdef ALLOW_DIFFKR_CONTROL
         foo5=diffkr%d
         call write_fld_xy_rl('adjdiffkr.',suff,foo5,myiter,1)
# endif
# ifdef ALLOW_HFLUX0_CONTROL
         foo4=qnet%d
         call write_fld_xy_rl('adjqnet.',suff,foo4,myiter,1)
# endif
# ifdef ALLOW_SFLUX0_CONTROL
         foo4=empmr%d
         call write_fld_xy_rl('adjempmr.',suff,foo4,myiter,1)
# endif
# ifdef ALLOW_TAUU0_CONTROL 
         foo4=fu%d
         call write_fld_xy_rl('adjfu.',suff,foo4,myiter,1)
# endif
# ifdef ALLOW_TAUV0_CONTROL 
         foo4=fv%d
         call write_fld_xy_rl('adjfv.',suff,foo4,myiter,1)
# endif
      endif
      END

