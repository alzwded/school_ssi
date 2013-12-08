C Copyright (c) 2013, Vlad Meșco
C All rights reserved.
C See LICENSE for a license description

C Routine used to encode a text using a secret key by applying four
C operations
      SUBROUTINE ENC(T, NT, K, NK, R)
C     Input
      INTEGER NT, NK
      INTEGER*1 T(NT), K(NK)
C     Output
      INTEGER*1 R(NT)
C     Local variables
      INTEGER I
C     Common
      INTEGER*1 H
      INTEGER MAGIC1, MAGIC2
      COMMON /KEY/ MAGIC1, MAGIC2, H
C     ------------------------------------------------------------
C     Initialize stuff
C Copy the text since we'll be working directly on the output
      R(1:NT) = T(1:NT)
C     First mix
C Mix in the key with the original text
      R(1:NK:2) = R(1:NK:2) + K(1:NK:2)
      DO I = 2, NK, 2
        R(I) = IEOR(R(I), H + K(I))
      END DO
C Apply some other sums and XOR's on the text...
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
      DO I = 4, NT - 4, MOD(ABS(H), 4) + 1
        R(I) = IEOR(R(I), R(I - 1))
      END DO
C     ------------------------------------------------------------
      RETURN
      END 
