Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275989AbRJYTRg>; Thu, 25 Oct 2001 15:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRJYTR0>; Thu, 25 Oct 2001 15:17:26 -0400
Received: from rosebud.imaginos.net ([64.173.180.66]:6784 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S276032AbRJYTRI>; Thu, 25 Oct 2001 15:17:08 -0400
Date: Thu, 25 Oct 2001 12:17:36 -0700 (PDT)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: <linux-kernel@vger.kernel.org>
Subject: dvd issue now only occurs in 2.4.13
Message-ID: <Pine.LNX.4.33.0110251212040.676-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I fixed my previous pci issue by replacing the motherboard with an intel I
had lying around, the scsi issue and hdc lost interupt issue have been
resolved, however, I am still noticing a difference between 2.4.9 and
2.4.13 in which the dvd performance has suffered tremendously. I have now
tested on two different machines that have the same model dvd player and
both lock up on streaming dvd with 2.4.13 but play fine on 2.4.9. There
are no Oops' or kernel messages whent he dvd player locks, it justs locks
... I wonder if anyone else has noticed this problem yet ?



			Jim

============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72GVVdygyS8O4zQ0RArViAKC0ABKAc0F60MYkdPHhoiQNoUtU2gCgtsGQ
MHHEQd6ROgSOT5UEQm5PEv8=
=Re0b
-----END PGP SIGNATURE-----


