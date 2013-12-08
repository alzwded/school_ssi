C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to insert pseudo-random characters in the output text
      SUBROUTINE SPACFR(T, NT, TS, NTS)
      IMPLICIT NONE
C     Input
      INTEGER NT
      INTEGER*1 T(NT)
C     Output
      INTEGER*1 TS(2 * NT)
      INTEGER NTS
C     Externals
      INTEGER*1 TOALPH, RNGLOG
      INTEGER RNGSED
      EXTERNAL TOALPH, RNGSED, RNGLOG
C     Locals
      INTEGER I, STATE, USED, MAXUSE
      INTEGER*1 E
      DATA I, USED /1, 0/
C     Common
      INTEGER*1 H
      INTEGER MAGIC1, MAGIC2
      COMMON /KEY/ MAGIC1, MAGIC2, H
C     ------------------------------------------------------------
C     Initializations
C RNGSED expects a 32b integer, so temporarily store H in an INTEGER*4
      STATE = H
C ...and feed it to RNGSED, and store the state
      STATE = RNGSED(STATE)
C Compute the maximum number of random characters to be inserted
      MAXUSE = (MOD(T(1), 64) + 1) * ((MOD(T(2), 64) + 1) / 2)
C Initialize the size of the output text
      NTS = 0
C     Perform
      DO WHILE (I.LE.NT)
        NTS = NTS + 1
        E = IAND(127, RNGLOG(STATE))
        IF (MOD(E, 7).LE.1 .AND. USED.LT.MAXUSE) THEN
C Generate a random character
          TS(NTS) = TOALPH(E)
          USED = USED + 1
        ELSE
C Store an existing character
          TS(NTS) = T(I)
          I = I + 1
        END IF
      END DO
C     ------------------------------------------------------------
      RETURN
      END
