Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbSK3GmR>; Sat, 30 Nov 2002 01:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbSK3GmR>; Sat, 30 Nov 2002 01:42:17 -0500
Received: from 174-121-ADSL.red.retevision.es ([80.224.121.174]:30403 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S267218AbSK3GmQ>; Sat, 30 Nov 2002 01:42:16 -0500
Date: Sat, 30 Nov 2002 07:49:10 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: khromy@lnuxlab.ath.cx (khromy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
Message-ID: <20021130064910.GD15426@jerry.marcet.dyndns.org>
References: <20021130013832.GF15682@jerry.marcet.dyndns.org> <Pine.LNX.4.50.0211292103200.26051-100000@montezuma.mastecende.com> <3DE82A4C.B8332D8E@digeo.com> <Pine.LNX.4.50.0211292306000.2495-100000@montezuma.mastecende.com> <20021130064807.GA20277@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20021130064807.GA20277@lnuxlab.ath.cx>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.18-wolk3.8 i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* khromy <khromy@lnuxlab.ath.cx> [021130 07:33]:

>BTW, I'm running 2.4.20-rc4-ac1+preempt and it seems to run good but
>whenever I leave for a few hours or wake up in the morning mozilla is
>swaped out.. Any idea when/how this might be fixed?

I have the problem without leaving it a few hours, but when I do it gets
definitely worse. Last vmstat output I quoted here showed around 256MB
swapped. A few hours later - the computer had been sitting idle, only
the mail server for three users was running which poses no overhead at
all -, the entire 512MB SWAP space was used. Why, I don't know.

I'm about to try 2.4.20-jam0, -aa derived. I'll post results from that
kernel later.


--=20
Javier Marcet <jmarcet@pobox.com>

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3oX2YACgkQx/ptJkB7frwCwQCeJ0NTcJSt88pc9ckBOQ85R1O0
JVMAnjwDLdnurFE4kmUpoaN222iTmpWc
=tzEV
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
