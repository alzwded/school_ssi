C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to remove the pseudo randomly inserted characters
C from a text based on the same entropy values
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
      SAVE /KEY/
      DATA USED, MAXUSE /0, 4096/
C     ------------------------------------------------------------
C     Initializations
      NT = 0
C RNGSED expects a 32b integer, so move H to an INTEGER*4
      STATE = H
C ...then send it to RNGSED and store the initial state
      STATE = RNGSED(STATE)
C     Perform
      DO I = 1, NTS
C Retrieve the next random number
        E = IAND(127, RNGLOG(STATE))
C If it's a random character, ignore it and count it
        IF (MOD(E, 7).LE.1 .AND. USED.LT.MAXUSE) THEN
          USED = USED + 1
C ...else, store the character in the output array
        ELSE
          NT = NT + 1
          T(NT) = TS(I)
        END IF
C If we have more than two output values we can compute the total
C number of useless characters
        IF (NT .EQ. 2) THEN
          MAXUSE = (MOD(T(1), 64) + 1) * ((MOD(T(2), 64) + 1) / 2)
        END IF
      END DO
C     ------------------------------------------------------------
      RETURN
      END
