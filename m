Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131208AbQKCTM7>; Fri, 3 Nov 2000 14:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbQKCTMt>; Fri, 3 Nov 2000 14:12:49 -0500
Received: from nat-40.kulnet.kuleuven.ac.be ([134.58.0.40]:13409 "EHLO
	maui.kotnet.org") by vger.kernel.org with ESMTP id <S131208AbQKCTMr>;
	Fri, 3 Nov 2000 14:12:47 -0500
Date: Fri, 3 Nov 2000 20:12:33 +0100 (CET)
From: Frederik Vanrenterghem <frederik@maui.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: Cmpci sound problem (test10)
Message-ID: <Pine.LNX.4.21.0011032008150.455-100000@maui.kotnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I've recently changed kernel versions, from 2.2.17 to 2.4.0-test10. Since
then, I have 'grainy' sound while playing mp3's as a user (a bit like an
old record). This does not happen when I play the mp3's as root. I didn't
have this problem in 2.2.17.
I guess this is some priority issue? Is there a way to change this
behaviour, 'cause I consider it sub-optimal to play mp3's as root.

Please CC me.

Thanks in advance,

Frederik

- -- 

Neutrinos have bad breadth.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Made with pgp4pine

iEYEARECAAYFAjoDDisACgkQjGz8qD1yPRC+2wCgvFigqrS63Rf8qdVlja8hDUqd
6ggAnA5wrrk63AHMgcLnBcZuEiMbO5pa
=d78d
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
