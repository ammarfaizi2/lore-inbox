Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbQKMAZb>; Sun, 12 Nov 2000 19:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129756AbQKMAZL>; Sun, 12 Nov 2000 19:25:11 -0500
Received: from [200.230.208.16] ([200.230.208.16]:38664 "EHLO plutao.vb.com.br")
	by vger.kernel.org with ESMTP id <S129116AbQKMAZG>;
	Sun, 12 Nov 2000 19:25:06 -0500
From: "Carlos E. Gorges" <carlos@techlinux.com.br>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Unresolved Symbols in wavefront module ( k 2.2.17 )
Date: Sun, 12 Nov 2000 22:17:40 -0200
X-Mailer: KMail [version 1.0.28]
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
MIME-Version: 1.0
Message-Id: <00111222283100.01504@shark.techlinux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit


Hi all,

This fixes the unresolved symbol detect_wf_mpu to module
wavefront .

Patch attached.

cya;
-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="wavefront-unresolved_symbols.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="wavefront-unresolved_symbols.diff.gz"

H4sICJszDzoAA3dhdmVmcm9udC11bnJlc29sdmVkX3N5bWJvbHMuZGlmZgCNjr1OxDAQhOv4KaZM
5PjihIuOhCYVBQUND2AFx4YVdw7450BCvDsJaWhAV+1q55udmchaiORxJJc+hB79cQ7V5OlsfKjC
nNxUvVt1ool2eoP+UpkQ4qI32UNyuJ/PqBs0sm/rvlkXKRnn/P+M7NYT7kaHuoXc923X7w+ou65j
wwBxLa/KA/g2hoEh8yYm7yBvGL4YmFCKHEWbnEYe4hhJg1zEZKLRUa0xrwn5eiL/Vv5oNKvHMZii
YPy3+3IbGD6XKmSR62ejX5Q3TzS7hd+QEk1RLMg3pnneF4sBAAA=

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
