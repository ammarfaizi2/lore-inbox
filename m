Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSLAHqV>; Sun, 1 Dec 2002 02:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSLAHqV>; Sun, 1 Dec 2002 02:46:21 -0500
Received: from 28-121-ADSL.red.retevision.es ([80.224.121.28]:1220 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S261518AbSLAHqU>; Sun, 1 Dec 2002 02:46:20 -0500
Date: Sun, 1 Dec 2002 08:53:45 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: khromy <khromy@lnuxlab.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021201075345.GA2483@jerry.marcet.dyndns.org>
References: <20021130182345.GA21410@lnuxlab.ath.cx> <20021130184317.GH28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20021130184317.GH28164@dualathlon.random>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.5.47-ac6 i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Andrea Arcangeli <andrea@suse.de> [021130 19:47]:
=20
>> > I'm about to try 2.4.20-jam0, -aa derived. I'll post results from that
>> > kernel later.
=20
>> aa runs beautifully but it locked up once on me..

>send me SYSRQ+T SYSRQ+P and everything else you know about it. if you
>have AGP enabled try to reproduce with 10_x86-fast-pte-2 backed out.

I spoke too fast. Just after sending the e-mail, I kept reading the
mailing-list within mutt while compiling sane-backends and it locked up.
It's the first time I try kmsgdump, which comes included in -aa, I
dumped the info to a FAT12 disk. Yet the messages.txt I found on the
disk shows nothing.
I attach it anyway, just in case, since it is 16384 bytes in size but
doubt it'll be of any use.
How else can I take down the kernel dump without any additional computer
at hand? I'd prefer not having to write it down, ... but I'll do it if
there's no other way.


--=20
Javier Marcet <jmarcet@pobox.com>

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3pwAkACgkQx/ptJkB7fryivwCcDVctO7QPDrM9F6nPd9/VIQup
+oQAniUZxaxK4Yz8Fq7fX4tIwXq/XHGx
=hLpy
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
