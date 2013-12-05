      SUBROUTINE TOB64(T, NT, T64)
      PARAMETER (MAGIC1=42)
C     Input
      INTEGER NT
      INTEGER*1 T(NT), T64(4 * NT)
C     Externals
      EXTERNAL INTLOG
C     Locals
      INTEGER I, J
      INTEGER*1 C, E
      INTEGER ALPHA(64) /97, 98, 99, 100, 101, 102, 103, 104, 105,      &
     &106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,  &
     &119, 120, 121, 122, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,   &
     &76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 48,   &
     &49, 50, 51, 52, 53, 54, 55, 56, 57, 34, 39/
C     ------------------------------------------------------------
      J = 1
      E = MAGIC1
      DO I = 1, NT
        E = IEOR(E, INTLOG(IEOR(MAGIC1, E * MAGIC1)))
C       High nibble
        C = ISHFT(IAND(240, T(I)), -2)
        T64(J) = ALPHA(IOR(C, IAND(IEOR(E, ISHFT(C, -2)), 3)) + 1)
C       Low nibble
        C = ISHFT(IAND(15, T(I)), 2)
        T64(J + 1) = ALPHA(IOR(C, IAND(IEOR(E, ISHFT(C, -2)), 3)) + 1)
C       Next
        J = J + 2
      END DO
C     ------------------------------------------------------------
      RETURN
      END
