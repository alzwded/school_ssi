      SUBROUTINE DESPCF(TS, NTS, T, NT)
      IMPLICIT NONE
C     Input
      INTEGER NTS
      INTEGER*1 TS(NTS)
C     Output
      INTEGER NT
      INTEGER*1 T(NTS)
C     Externals
      INTEGER*1 FROMAB, RNGLOG
      INTEGER RNGSED 
      EXTERNAL FROMAB, RNGSED, RNGLOG
C     Locals
      INTEGER I, USED
      INTEGER*1 E
      INTEGER STATE, MAXUSE
C     Common
      INTEGER*1 H
      INTEGER MAGIC1, MAGIC2
      COMMON /KEY/ MAGIC1, MAGIC2, H
C     ------------------------------------------------------------
C     Initializations
      STATE = H
      STATE = RNGSED(STATE)
      NT = 0
      USED = 0
      MAXUSE = 4096
C     Perform
      DO I = 1, NTS
        E = IAND(127, RNGLOG(STATE))
        IF (MOD(E, 7).LE.1 .AND. USED.LT.MAXUSE) THEN
          USED = USED + 1
        ELSE
          NT = NT + 1
          T(NT) = TS(I)
        END IF
        IF (NT .EQ. 2) THEN
          MAXUSE = (MOD(T(1), 64) + 1) * ((MOD(T(2), 64) + 1) / 2)
        END IF
      END DO
C     ------------------------------------------------------------
      RETURN
      END
