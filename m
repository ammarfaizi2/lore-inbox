Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJYUo0>; Thu, 25 Oct 2001 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276255AbRJYUoR>; Thu, 25 Oct 2001 16:44:17 -0400
Received: from rosebud.imaginos.net ([64.173.180.66]:57728 "EHLO
	rosebud.imaginos.net") by vger.kernel.org with ESMTP
	id <S276249AbRJYUoJ>; Thu, 25 Oct 2001 16:44:09 -0400
Date: Thu, 25 Oct 2001 13:44:39 -0700 (PDT)
From: Jim Hull <imaginos@imaginos.net>
X-X-Sender: <imaginos@rosebud>
To: <linux-kernel@vger.kernel.org>
Subject: Re: dvd issue now only occurs in 2.4.13
In-Reply-To: <Pine.LNX.4.33.0110251212040.676-100000@rosebud>
Message-ID: <Pine.LNX.4.33.0110251341200.1086-100000@rosebud>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

All,
	This issue does not occur in linux-2.4.12-ac6 from Alans patches.
Anyhow, FYI.


			Jim

============================
They that give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.

- --Benjamin Franklin,
Historical Review of Pennyslvania, 1759



On Thu, 25 Oct 2001, Jim Hull wrote:

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




- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
- ------------ Output from gpg ------------
gpg: Signature made Thu Oct 25 12:17:41 2001 PDT using DSA key ID C3B8CD0D
gpg: Good signature from "James Hull <imaginos@imaginos.net>"


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72Hm8dygyS8O4zQ0RAnO9AKCTpXJTzTWyAn9QjCDfs1jQqo4etQCcD96H
/N3QNycRLIuS5dO799QybZI=
=o8Js
-----END PGP SIGNATURE-----


