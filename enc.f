      SUBROUTINE ENC(T, NT, K, NK, R)
      PARAMETER (MAGIC2 = 3)
C     Input
      INTEGER NT, NK
      INTEGER*1 T(NT), K(NK)
C     Output
      INTEGER*1 R(NT)
C     Externals
C     Local variables
      INTEGER I
C     Common
      INTEGER*1 H
      INTEGER MAGIC1
      COMMON /KEY/ MAGIC1, H
C     ------------------------------------------------------------
C     Initialize stuff
      R(1:NT) = T(1:NT)
C     First mix
      R(1:NK:2) = R(1:NK:2) + K(1:NK:2)
      DO I = 2, NK, 2
        R(I) = IEOR(R(I), H + K(I))
      END DO
C     Second mix
      DO I = NK + 1, NT
        R(I) = R(I) + R(I - NK) + R(I - NK + MAGIC2)
      END DO
C     Third mix
      DO I = NK + 1, NT / 2
        R(I) = IEOR(R(I), H + R(NT - I + 1))
        R(NT - I + 1) = R(NT - I + 1) + R(I)
      END DO
C     Fourth mix
      DO I = 1, NT
        R(I) = R(MOD(I + R(I) * H, NT)) + R(I)
      END DO
C     ------------------------------------------------------------
      RETURN
      END 
