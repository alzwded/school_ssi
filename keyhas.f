      SUBROUTINE KEYHAS(K, NK, MAGIC1)
      IMPLICIT NONE
C     Input
      INTEGER NK
      INTEGER*1 K(NK)
      INTEGER MAGIC1
C     Common
      INTEGER*1 H
      INTEGER MAG1
      COMMON /KEY/ MAG1, H
C     Local
      INTEGER I
C     ------------------------------------------------------------
      MAG1 = MAGIC1
      H = 0
      DO I = 1, NK
        H = H + K(I)
      END DO
C     ------------------------------------------------------------
      RETURN
      END
