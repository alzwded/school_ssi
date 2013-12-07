      BLOCK DATA ALPHBT
      INTEGER*1 ALPHA(64)
      COMMON /ALPHA1/ ALPHA
      DATA ALPHA        /97, 98, 99, 100, 101, 102, 103, 104, 105,      &
     &106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,  &
     &119, 120, 121, 122, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,   &
     &76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 48,   &
     &49, 50, 51, 52, 53, 54, 55, 56, 57, 34, 39/
      END

      FUNCTION TOABET(C, E)
      IMPLICIT NONE
      INTEGER*1 TOABET
C     Input
      INTEGER*1 C, E
C     Externals
      EXTERNAL ALPHBT
      INTEGER*1 ALPHA(64)
      COMMON /ALPHA1/ ALPHA
C     ------------------------------------------------------------
      TOABET =                                                          &
     &  ALPHA(IAND(63, IEOR(E, IOR(C, IAND(3, ISHFT(C, -2))))) + 1)
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
      INTEGER*1 ALPHA(64)
      COMMON /ALPHA1/ ALPHA
C     ------------------------------------------------------------
      TOALPH = ALPHA(MOD(E, 64) + 1)
C     ------------------------------------------------------------
      RETURN
      END
