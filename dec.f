C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to decode a text, applying the four mix operations in 
C reverse
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
      SAVE /KEY/
C     ------------------------------------------------------------
C     Initialization
C Make a copy of the text since we'll be working on it
      R(1:NT) = T(1:NT)
C     Fourth demix
C The original was 4:NT-4:MOD(ABS(H),4)+1, so do that in reverse
      DO I = NT - 4 - MOD((NT - 4) - 4, MOD(ABS(H), 4) + 1),            &
     &    4, -(MOD(ABS(H), 4) + 1)
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
C Finally, remove the key from the text
      DO I = 2, NK, 2
        R(I) = IEOR(R(I), H + K(I))
      ENDDO
      R(1:NK:2) = R(1:NK:2) - K(1:NK:2)
C     ------------------------------------------------------------
      RETURN
      END
