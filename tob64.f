C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to convert a text to a base64 representation, all the
C while adding interdependencies between characters
      SUBROUTINE TOB64(T, NT, T64)
      IMPLICIT NONE
C     Input
      INTEGER NT
      INTEGER*1 T(NT)
C     Output
      INTEGER*1 T64(2 * NT)
C     Externals
      INTEGER*1 RNGLOG, TOABET
      INTEGER RNGSED
      EXTERNAL RNGSED, RNGLOG, TOABET
C     Common
      INTEGER*1 H
      INTEGER MAGIC1, MAGIC2
      COMMON /KEY/ MAGIC1, MAGIC2, H
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
C If we have enough characters, XOR one with a previously computed val
        IF (J.GE.2) THEN
          C = IAND(IEOR(C, T64(J - 1)), 60)
        END IF
C Generate a base64 character based on C and a random number E
        T64(J) = TOABET(C, E)
C       Low nibble
        C = ISHFT(IAND(15, T(I)), 2)
C Generate a base64 character based on C and a random number E
        T64(J + 1) = TOABET(C, E)
C       Next
        J = J + 2
      END DO
C     ------------------------------------------------------------
      RETURN
      END
