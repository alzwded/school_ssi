      SUBROUTINE ENC(T, NT, K, NK, R)
      PARAMETER (MAGIC2 = 3)
C     Input
      INTEGER NT, NK
      INTEGER*1 T(NT), K(NK), R(NT)
C     Externals
C     Local variables
      INTEGER*1 H
      INTEGER I
C     ------------------------------------------------------------
C     Initialize stuff
      H = 0
      DO I = 1, nk
        H = H + K(I)
      END DO
      R(1:NT) = T(1:NT)
C     First mix
      DO I = 1, NK, 2
        R(I) = R(I) + K(I)
      END DO
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
