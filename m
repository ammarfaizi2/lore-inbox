Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129765AbQLDV6t>; Mon, 4 Dec 2000 16:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130003AbQLDV6j>; Mon, 4 Dec 2000 16:58:39 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:55056 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129765AbQLDV61>;
	Mon, 4 Dec 2000 16:58:27 -0500
Date: Mon, 4 Dec 2000 22:27:05 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <Pine.LNX.4.30.0012041249020.22668-100000@anime.net>
Message-ID: <Pine.LNX.4.30.0012042223520.1412-100000@toor.thn.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dan Hollis wrote:

> On Tue, 5 Dec 2000, Gerard Sharp wrote:
> > Gnea wrote:
> > > >  [1.] One line summary of the problem:
> > > >  Intermittent corruption of 4 bytes in SMP kernels using HPT366
> > > [snip]
> > > Have you tried updating the bios on the bp6? This solved a LOT of
> > > problems for me, and afaik, ru is the latest...
> > RU seems the latest. Flashed bios as per your nicely detailed
> > instructions.
> > No improvement in condition, alas.
>
> HPT366 on BP6 is just broken. Corruption and lockups happen under
> microsoft-windoze as well.
>

Not my experience Dan.

I've used my BP6 + HPT366 for a while now and I haven't had on lockup.
No corruption either.

Presently I use 2.4.0-test11-p4 and I have been following the 2.3.* kernel
since the day I got the BP6.

I have two Celeron 500 which are *not* o/c.
I have seti@home running on this box 24/7.
I use the latest BIOS.

I guess I'm lucky *grin*



/Richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6LAwsUSLExYo23RsRAtY+AKCOuqpfcSa73zzpHQfddSY/7JG8IACffPRe
UzfNUJ7t3y2jdsS4jmS4Ggg=
=FdqO
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
