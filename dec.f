      SUBROUTINE DEC(T, NT, K, NK, R)
      IMPLICIT NONE
C     Input
      INTEGER NT, NK
      INTEGER*1 T(NT), K(NK)
C     Output
      INTEGER*1 R(NT)
C     Local
      INTEGER I
C     Common
      INTEGER*1 H
      INTEGER MAGIC1, MAGIC2
      COMMON /KEY/ MAGIC1, MAGIC2, H
      INTEGER TMP
C     ------------------------------------------------------------
C     Initialization
      R(1:NT) = T(1:NT)
C     Fourth demix
      DO I = 4, NT - 4, MOD(ABS(H), 4) + 1 
        TMP = I
      END DO
      DO I = TMP, 4, -(MOD(ABS(H), 4) + 1)
        R(I) = IEOR(R(I), R(I - 1))
      END DO
C     Third demix
      DO I = NK + 1, NT / 2
        R(NT - I + 1) = R(NT - I + 1) - R(I)
        R(I) = IEOR(R(I), H + R(NT - I + 1))
      END DO
C     Second demix
      DO I = NT, NK + 1, -1
        R(I) = R(I) - R(I - NK + MAGIC2) - R(I - NK)
      END DO
C     First demix
      DO I = 2, NK, 2
        R(I) = IEOR(R(I), H + K(I))
      ENDDO
      R(1:NK:2) = R(1:NK:2) - K(1:NK:2)
C     ------------------------------------------------------------
      RETURN
      END
