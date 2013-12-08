C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to initialize the engine with the key hash and MAGIC
C values
      SUBROUTINE KEYHAS(K, NK, MAGIC1, MAGIC2)
      IMPLICIT NONE
C     Input
      INTEGER NK
      INTEGER*1 K(NK)
      INTEGER MAGIC1, MAGIC2
C     Common
      INTEGER*1 H
      INTEGER MAG1, MAG2
      COMMON /KEY/ MAG1, MAG2, H
C     Local
      INTEGER I
C     ------------------------------------------------------------
      MAG1 = MAGIC1
      MAG2 = MAGIC2
C Compute key hash. Since this is done only here, this can be upgraded
C to something more professional in v2.0
      H = 0
      DO I = 1, NK
        H = H + K(I)
      END DO
C     ------------------------------------------------------------
      RETURN
      END
