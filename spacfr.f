      SUBROUTINE SPACFR(T, NT, TS, NTS)
      IMPLICIT NONE
C     Input
      INTEGER NT
      INTEGER*1 T(NT)
C     Output
      INTEGER*1 TS(4 * NT)
      INTEGER NTS
C     Externals
      INTEGER*1 TOALPH, RNGSED, RNGLOG
      EXTERNAL TOALPH, RNGSED, RNGLOG
C     Locals
      INTEGER I, STATE, USED
      INTEGER*1 E
      DATA I, USED /1, 0/
C     Common
      INTEGER*1 H
      COMMON /KEYSTF/ H
C     ------------------------------------------------------------
C     Initializations
      STATE = RNGSED(H)
      NTS = 0
C     Perform
      DO WHILE (I.LE.NT)
        NTS = NTS + 1
        E = IAND(127, RNGLOG(STATE))
        IF (MOD(E, 7).LE.1 .AND. USED.LT.(3 * NT)) THEN
          TS(NTS) = TOALPH(E)
          USED = USED + 1
        ELSE
          TS(NTS) = T(I)
          I = I + 1
        END IF
      END DO
C     ------------------------------------------------------------
      RETURN
      END
