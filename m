Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSHCQs3>; Sat, 3 Aug 2002 12:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSHCQs3>; Sat, 3 Aug 2002 12:48:29 -0400
Received: from dialin-145-254-149-121.arcor-ip.net ([145.254.149.121]:18926
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S317606AbSHCQs2>; Sat, 3 Aug 2002 12:48:28 -0400
Date: Sat, 3 Aug 2002 07:07:52 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.29 / 2.5.31 floppy/apm support
Message-ID: <20020803050752.GA2976@schottelius.org>
References: <20020803050633.GA459@schottelius.org> <Pine.LNX.4.44.0208030842210.5119-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208030842210.5119-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thunder from the hill [Sat, Aug 03, 2002 at 08:42:50AM -0600]:
> On Sat, 3 Aug 2002, Nico Schottelius wrote:
> > Then I tried to shutdown the host via network, which fails because of a=
pm
> > module cannot be included in kernel in 2.5.29.
>=20
> Well, have you tried built-in apm module yet?

yes, doesn't work either.
I am currently trying to find a kernel, which supports wifi, floppy,apm.
As you can see in my header I downgraded to 2.5.24 right now, but floppy
is broken herein, too.
Now I am trying 2.5.20, perhaps this works ...

I am still hoping that in 2.5.31/32 floppy and apm will work again.

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9S2UotnlUggLJsX0RAkZsAJ4rJsNDSW1U8UaDzaXWSjdiV2ubugCeMwYi
9PkVmlIuBr0opjsYxPcVQ+Q=
=CKjg
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
