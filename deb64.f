      SUBROUTINE DEB64(T64, NT64, T)
      IMPLICIT NONE
C     Input
      INTEGER NT64
      INTEGER*1 T64(NT64)
C     Output
      INTEGER*1 T(NT64 / 2)
C     Externals
      INTEGER*1 FROMAB
      EXTERNAL FROMAB, RNGMAT
C     Common
      INTEGER*1 H
      INTEGER MAGIC1, MAGIC2
      COMMON /KEY/ MAGIC1, MAGIC2, H
C     Locals
      INTEGER I
      INTEGER NT
      INTEGER*1 C, E
      INTEGER*1 A(NT64 / 2)
C     ------------------------------------------------------------
C     Initializations
      NT = NT64 / 2
      CALL RNGMAT(MAGIC1, NT, A)
C     Perform
      DO I = NT, 1, -1
        E = A(I)
C       High nibble
        C = FROMAB(T64(2 * I - 1), E)
        IF (I.GT.2) THEN
          C = IAND(60, IEOR(C, T64(2 * I - 2)))
        END IF
        C = ISHFT(C, 2)
C       Low nibble
        C = IOR(C, ISHFT(FROMAB(T64(2 * I), E), -2))
C       Save
        T(I) = C
      END DO
C     ------------------------------------------------------------
      RETURN
      END
