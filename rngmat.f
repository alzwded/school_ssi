      SUBROUTINE RNGMAT(SEED, NA, A)
      IMPLICIT NONE
C     Input
      INTEGER SEED, NA
C     Output
      INTEGER*1 A(NA)
C     Externals
      INTEGER*1 RNGLOG
      INTEGER RNGSED
      EXTERNAL RNGLOG, RNGSED
C     Local
      INTEGER I, STATE
C     ------------------------------------------------------------
      STATE = RNGSED(SEED)
      DO I = 1, NA
        A(I) = RNGLOG(STATE)
      END DO
C     ------------------------------------------------------------
      RETURN
      END
