Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSIAVY1>; Sun, 1 Sep 2002 17:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSIAVY1>; Sun, 1 Sep 2002 17:24:27 -0400
Received: from [216.38.156.94] ([216.38.156.94]:33286 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S318020AbSIAVYZ>; Sun, 1 Sep 2002 17:24:25 -0400
Date: Sun, 1 Sep 2002 14:28:34 -0700
From: Dmitri <dmitri@users.sourceforge.net>
To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3x SMP boot prob
Message-ID: <20020901212834.GC1470@usb.networkfab.com>
Mail-Followup-To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>,
	linux-kernel@vger.kernel.org
References: <Pine.BSF.4.44.0209012207000.988-100000@e0-0.zab2.int.zabbadoz.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.44.0209012207000.988-100000@e0-0.zab2.int.zabbadoz.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Bjoern A. Zeeb <bzeeb-lists@lists.zabbadoz.net>:

> bad: schedule() with irqs disabled!
> d7fcdf70 c0315af6 c02e2900 c011d42e 0000000a 00000400 c0253f1f d7fcdfa8
>        00000000 00000000 00000001 c029e2f9 c0253f08 00000001 00000000 d7f=
ce9e0
>        00000000 00000000 00000000 00000000 c02a0c15 00000282 c02869bc d7f=
d1f7c
> Call Trace: [<c011d42e>] [<c011d420>]

I saw similar problems yesterday, on 2.5.32 SMP, freshly pulled from
bk://linuxusb.bkbits.net/usb-2.5. They are still in the log, and if anyone
is interested I can find them and run them through ksymoops. I actually
did that quickly when I saw them first, but I didn't save the decoded
trace.

Dmitri

--=20
163. When planning an expedition, I will choose a route for my forces
  that does not go through thick, leafy terrain conveniently located
  near the rebel camp.
  ("Evil Overlord" by Peter Anspach and John VanSickl)

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9coaCXksyLpO6T4IRAhS0AJsH77z6hyDPe/92qPFonriAz1+IxACgh+32
g18X4rCq2DG1Xc6Zgkm742w=
=xt+1
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
