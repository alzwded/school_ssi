      BLOCK DATA ALPHBT
      INTEGER*1 ALPHA(64), PERM(64)
      COMMON /ALPHA1/ ALPHA, PERM
      DATA ALPHA        /97, 98, 99, 100, 101, 102, 103, 104, 105,      &
     &106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,  &
     &119, 120, 121, 122, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,   &
     &76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 48,   &
     &49, 50, 51, 52, 53, 54, 55, 56, 57, 34, 39/
      DATA PERM  /1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,&
     &17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33&
     &, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, &
     &50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64/
      END

      SUBROUTINE SETPER(PRM)
      IMPLICIT NONE
C     Input
      INTEGER*1 PRM(64)
C     Externals
      EXTERNAL ALPHBT
      INTEGER*1 ALPHA(64), P(64)
      COMMON /ALPHA1/ ALPHA, P
C     Local
      INTEGER I
      LOGICAL TEST
C     ------------------------------------------------------------
      P = PRM
C     ------------------------------------------------------------
      RETURN
      END

      FUNCTION FROMAB(C, E)
      IMPLICIT NONE
      INTEGER*1 FROMAB
C     Input
      INTEGER*1 C, E
C     Externals
      EXTERNAL ALPHBT
      INTEGER*1 ALPHA(64), PERM(64)
      COMMON /ALPHA1/ ALPHA, PERM
C     Local
      INTEGER I
      INTEGER*1 CH
C     ------------------------------------------------------------
      DO I = 1, 64
        IF (ALPHA(PERM(I)).EQ.C) THEN
          GO TO 10
        END IF
      END DO
   10 FROMAB =                                                          &
     &  IAND(60, IEOR(E, I - 1))
C     ------------------------------------------------------------
      RETURN
      END

      FUNCTION TOABET(C, E)
      IMPLICIT NONE
      INTEGER*1 TOABET
C     Input
      INTEGER*1 C, E
C     Externals
      EXTERNAL ALPHBT
      INTEGER*1 ALPHA(64), PERM(64)
      COMMON /ALPHA1/ ALPHA, PERM
C     ------------------------------------------------------------
      TOABET = ALPHA(PERM(                                              &
     &    IAND(63, IEOR(E, IOR(C, IAND(3, ISHFT(C, -2))))) + 1))
C     ------------------------------------------------------------
      RETURN
      END

      FUNCTION TOALPH(E)
      IMPLICIT NONE
      INTEGER*1 TOALPH
C     Input
      INTEGER*1 E
C     Externals
      EXTERNAL ALPHBT
      INTEGER*1 ALPHA(64), PERM(64)
      COMMON /ALPHA1/ ALPHA, PERM
C     ------------------------------------------------------------
      TOALPH = ALPHA(MOD(E, 64) + 1)
C     ------------------------------------------------------------
      RETURN
      END
