Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbRA3OBZ>; Tue, 30 Jan 2001 09:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRA3OBP>; Tue, 30 Jan 2001 09:01:15 -0500
Received: from eden.dei.uc.pt ([193.137.203.230]:34564 "EHLO eden.dei.uc.pt")
	by vger.kernel.org with ESMTP id <S129776AbRA3OA4>;
	Tue, 30 Jan 2001 09:00:56 -0500
From: Antonio Miguel Trindade <trindade@dei.uc.pt>
Organization: D.E.I F.C.T.U.C.
To: linux-kernel@vger.kernel.org
Subject: RTC hardware clock option
Date: Tue, 30 Jan 2001 14:00:43 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Message-Id: <01013014004308.23105@polaris>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just would like to ask all of you what has the option "RTC stores time in 
GMT" have to do with APM... The hardware clock in my machine stores time in 
GMT, but I do not want APM, so why do I have to have APM just to have that 
option enabled...

Perhaps the intention is to remove that depency, but it has not been done out 
of lazyness... (no pun intended, Linus).

Yours truly,
António Trindade

- -- 
A year spent in artificial intelligence
is enough to make one believe in God.

    -------------------------------
     António Miguel F. M. Trindade
        System's Administrator
           D.E.I. F.C.T.U.C.
    -------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6dskLKh8km1Ma45URAoGmAJ0V/SptLcki2yzq3VIpsJUAl9YIhgCaA5jB
CUY8kiZto3ZTGnWCPCx/FSg=
=QUSP
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
