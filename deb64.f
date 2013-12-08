C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to decode a base64 encoded text back to the original
C data
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
C The length of the original text is exactly half
      NT = NT64 / 2
C Generate NT random numbers since we'll use those in reverse when
C decoding
      CALL RNGMAT(MAGIC1, NT, A)
C     Perform
      DO I = NT, 1, -1
        E = A(I)
C Grab the high and low nibbles and OR them together again
C       High nibble
        C = FROMAB(T64(2 * I - 1), E)
C Also XOR some values with previous values
        IF (I.GE.2) THEN
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
