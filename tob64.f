      SUBROUTINE TOB64(T, NT, T64)
      IMPLICIT NONE
      INTEGER MAGIC1
      PARAMETER (MAGIC1=42)
C     Input
      INTEGER NT
      INTEGER*1 T(NT)
C     Output
      INTEGER*1 T64(2 * NT)
C     Externals
      INTEGER*1 RNGSED, RNGLOG, TOABET
      EXTERNAL RNGSED, RNGLOG, TOABET
C     Locals
      INTEGER I, J, STATE
      INTEGER*1 C, E
      DATA J /1/
C     ------------------------------------------------------------
C     Initializations
      STATE = RNGSED(MAGIC1)
C     Perform
      DO I = 1, NT
        E = RNGLOG(STATE)
C       High nibble
        C = ISHFT(IAND(240, T(I)), -2)
        T64(J) = TOABET(C, E)
C       Low nibble
        C = ISHFT(IAND(15, T(I)), 2)
        T64(J + 1) = TOABET(C, E)
C       Next
        J = J + 2
      END DO
C     ------------------------------------------------------------
      RETURN
      END
