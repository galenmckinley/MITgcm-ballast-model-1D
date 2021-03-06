C $Header: /u/gcmpack/MITgcm/pkg/autodiff/active_file.F,v 1.8 2011/11/05 19:20:42 heimbach Exp $
C $Name:  $

#include "AUTODIFF_OPTIONS.h"

c     ==================================================================
c
c     active_file.F: Routines to handle the I/O of the active file for
c                    the adjoint calculations. All files are direct
c                    access files.
c
c     Routines
c
c    o  active_read_xy         - Read  an active 2D variable from file.
c    o  active_read_xyz        - Read  an active 3D variable from file.
c    o  active_read_xz         - Read  an active 2D xz-slice from file.
c    o  active_read_yz         - Read  an active 2D yz-slice from file.
c
c    o  active_write_xy        - Write an active 2D variable to a file.
c    o  active_write_xyz       - Write an active 3D variable to a file.
c    o  active_write_xz        - Write an active 2D xz-slice to a file.
c    o  active_write_yz        - Write an active 2D yz-slice to a file.
c
c        changed: Christian Eckert eckert@mit.edu 24-Apr-2000
c                 - Added routines that do active writes on tiles
c                   instead of a whole thread.
c        changed: heimbach@mit.edu 05-Mar-2001
c                 - added active file handling of xz-/yz-arrays
c
c     ==================================================================


CBOP
C     !ROUTINE: active_read_xy
C     !INTERFACE:
      subroutine active_read_xy(
     I                           active_var_file,
     O                           active_var,
     I                           irec,
     I                           doglobalread,
     I                           lAdInit,
     I                           myOptimIter,
     I                           mythid
     I                         , dummy
     &                         )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_read_xy
c     ==================================================================
c     o Read an active 2D (XY) variable from file.
c     started: Christian Eckert eckert@mit.edu 30-Jun-1999
c     ==================================================================
c     SUBROUTINE active_read_xy
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

C     !INPUT/OUTPUT PARAMETERS:
c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
c     doglobalread:    flag for global or local read/write
c                      (default: .false.)
c     lAdInit:         initialisation of corresponding adjoint
c                      variable and write to active file
      character*(*) active_var_file
      _RL     active_var(1-olx:snx+olx,1-oly:sny+oly,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      logical doglobalread
      logical lAdInit
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr

c     == end of interface ==
CEOP

      mynr = 1
      call active_read_rl( active_var_file, active_var, doglobalread,
     &                     lAdInit, irec, mynr,
     &                     FORWARD_SIMULATION, myOptimIter, mythid)

      return
      end

c     ==================================================================

CBOP
C     !ROUTINE: active_read_xyz
C     !INTERFACE:
      subroutine active_read_xyz(
     I                            active_var_file,
     O                            active_var,
     I                            irec,
     I                            doglobalread,
     I                            lAdInit,
     I                            myOptimIter,
     I                            mythid
     I                         , dummy
     &                           )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_read_xyz
c     ==================================================================
c     o Read an active 3D variable from file.
c     started: Christian Eckert eckert@mit.edu 30-Jun-1999
c     ==================================================================
c     SUBROUTINE active_read_xyz
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

C     !INPUT/OUTPUT PARAMETERS:
c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
c     doglobalread:    flag for global or local read/write
c                      (default: .false.)
c     lAdInit:         initialisation of corresponding adjoint
c                      variable and write to active file
      character*(*) active_var_file
      _RL active_var(1-olx:snx+olx,1-oly:sny+oly,nr,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      logical doglobalread
      logical lAdInit
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr

c     == end of interface ==
CEOP

      mynr = nr
      call active_read_rl( active_var_file, active_var, doglobalread,
     &                     lAdInit, irec, mynr,
     &                     FORWARD_SIMULATION, myOptimIter, mythid)

      return
      end

c     ==================================================================


CBOP
C     !ROUTINE: active_read_xz
C     !INTERFACE:
      subroutine active_read_xz(
     I                           active_var_file,
     O                           active_var,
     I                           irec,
     I                           doglobalread,
     I                           lAdInit,
     I                           myOptimIter,
     I                           mythid
     I                         , dummy
     &                         )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_read_xz
c     ==================================================================
c     o Read an active 2D xz-slice from file.
c     started: heimbach@mit.edu 05-Mar-2001
c     ==================================================================
c     SUBROUTINE active_read_xz
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

C     !INPUT/OUTPUT PARAMETERS:
c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
c     doglobalread:    flag for global or local read/write
c                      (default: .false.)
c     lAdInit:         initialisation of corresponding adjoint
c                      variable and write to active file
      character*(*) active_var_file
      _RL     active_var(1-olx:snx+olx,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      logical doglobalread
      logical lAdInit
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr

c     == end of interface ==
CEOP

      mynr = nr
      call active_read_xz_rl( active_var_file, active_var, doglobalread,
     &                     lAdInit, irec, mynr,
     &                     FORWARD_SIMULATION, myOptimIter, mythid)

      return
      end

c     ==================================================================


CBOP
C     !ROUTINE: active_read_yz
C     !INTERFACE:
       subroutine active_read_yz(
     I                           active_var_file,
     O                           active_var,
     I                           irec,
     I                           doglobalread,
     I                           lAdInit,
     I                           myOptimIter,
     I                           mythid
     I                         , dummy
     &                         )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_read_yz
c     ==================================================================
c     o Read an active 2D yz-slice from file.
c     started: heimbach@mit.edu 05-Mar-2001
c     ==================================================================
c     SUBROUTINE active_read_yz
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

C     !INPUT/OUTPUT PARAMETERS:
c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
c     doglobalread:    flag for global or local read/write
c                      (default: .false.)
c     lAdInit:         initialisation of corresponding adjoint
c                      variable and write to active file
      character*(*) active_var_file
      _RL     active_var(1-oly:sny+oly,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      logical doglobalread
      logical lAdInit
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr

c     == end of interface ==
CEOP

      mynr = nr
      call active_read_yz_rl( active_var_file, active_var, doglobalread,
     &                     lAdInit, irec, mynr,
     &                     FORWARD_SIMULATION, myOptimIter, mythid)

      return
      end

c     ==================================================================

CBOP
C     !ROUTINE: active_write_xy
C     !INTERFACE:
      subroutine active_write_xy(
     I                            active_var_file,
     I                            active_var,
     I                            irec,
     I                            myOptimIter,
     I                            mythid
     I                         , dummy
     &                          )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_write_xy
c     ==================================================================
c     o Write an active 2D variable to a file.
c     started: Christian Eckert eckert@mit.edu 30-Jun-1999
c     ==================================================================
c     SUBROUTINE active_write_xy
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
      character*(*) active_var_file
      _RL     active_var(1-olx:snx+olx,1-oly:sny+oly,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr
      logical globalfile

c     == end of interface ==
CEOP

      mynr = 1
      globalfile = .false.

      call active_write_rl( active_var_file, active_var, globalfile,
     &                      irec, mynr,
     &                      FORWARD_SIMULATION, myOptimIter, mythid )

      return
      end

c     ==================================================================

CBOP
C     !ROUTINE: active_write_xyz
C     !INTERFACE:
      subroutine active_write_xyz(
     I                             active_var_file,
     I                             active_var,
     I                             irec,
     I                             myOptimIter,
     I                             mythid
     I                         , dummy
     &                           )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_write_xyz
c     ==================================================================
c     o Write an active 3D variable to a file.
c     started: Christian Eckert eckert@mit.edu 30-Jun-1999
c     ==================================================================
c     SUBROUTINE active_write_xyz
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
      character*(*) active_var_file
      _RL active_var(1-olx:snx+olx,1-oly:sny+oly,nr,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr
      logical globalfile

c     == end of interface ==
CEOP

      mynr = nr
      globalfile = .false.
      call active_write_rl(active_var_file, active_var, globalfile,
     &                     irec, mynr,
     &                     FORWARD_SIMULATION, myOptimIter, mythid)

      return
      end

c     ==================================================================

CBOP
C     !ROUTINE: active_write_xz
C     !INTERFACE:
      subroutine active_write_xz(
     I                            active_var_file,
     I                            active_var,
     I                            irec,
     I                            myOptimIter,
     I                            mythid
     I                         , dummy
     &                          )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_write_xz
c     ==================================================================
c     o Write an active 2D xz-slice to a file.
c     started: heimbach@mit.edu 05-Mar-2001
c     ==================================================================
c     SUBROUTINE active_write_xz
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
      character*(*) active_var_file
      _RL     active_var(1-olx:snx+olx,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr
      logical globalfile

c     == end of interface ==
CEOP

      mynr = nr
      globalfile = .false.

      call active_write_xz_rl( active_var_file, active_var, globalfile,
     &                      irec, mynr,
     &                      FORWARD_SIMULATION, myOptimIter, mythid )

      return
      end

c     ==================================================================

CBOP
C     !ROUTINE: active_write_yz
C     !INTERFACE:
      subroutine active_write_yz(
     I                            active_var_file,
     I                            active_var,
     I                            irec,
     I                            myOptimIter,
     I                            mythid
     I                         , dummy
     &                          )

C     !DESCRIPTION: \bv
c     ==================================================================
c     SUBROUTINE active_write_yz
c     ==================================================================
c     o Write an active 2D variable to a file.
c     started: heimbach@mit.edu 05-Mar-2001
c     ==================================================================
c     SUBROUTINE active_write_yz
c     ==================================================================
C     \ev

C     !USES:
      implicit none

c     == global variables ==
#include "EEPARAMS.h"
#include "SIZE.h"

c     == routine arguments ==
c     active_var_file: filename
c     active_var:      array
c     irec:            record number
c     myOptimIter:     number of optimization iteration (default: 0)
c     mythid:          thread number for this instance
      character*(*) active_var_file
      _RL     active_var(1-oly:sny+oly,nsx,nsy)
      integer irec
      integer myOptimIter
      integer mythid
      _RL     dummy

C     !LOCAL VARIABLES:
c     == local variables ==
      integer mynr
      logical globalfile

c     == end of interface ==
CEOP

      mynr = nr
      globalfile = .false.

      call active_write_yz_rl( active_var_file, active_var, globalfile,
     &                      irec, mynr,
     &                      FORWARD_SIMULATION, myOptimIter, mythid )

      return
      end
