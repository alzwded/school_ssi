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
      H = 0
      DO I = 1, NK
        H = H + K(I)
      END DO
C     ------------------------------------------------------------
      RETURN
      END
