Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318232AbSHDVUy>; Sun, 4 Aug 2002 17:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318234AbSHDVUy>; Sun, 4 Aug 2002 17:20:54 -0400
Received: from dialin-145-254-149-035.arcor-ip.net ([145.254.149.35]:19182
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S318232AbSHDVUx>; Sun, 4 Aug 2002 17:20:53 -0400
Date: Sun, 4 Aug 2002 07:42:28 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.29 / 2.5.31 floppy/apm support
Message-ID: <20020804054228.GA11639@schottelius.org>
References: <20020803050752.GA2976@schottelius.org> <Pine.LNX.4.44.0208031231450.5119-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208031231450.5119-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thunder from the hill [Sat, Aug 03, 2002 at 12:37:51PM -0600]:
> On Sat, 3 Aug 2002, Nico Schottelius wrote:
> > I am currently trying to find a kernel, which supports wifi, floppy,apm.
>=20
> Well, you won't find any. The days when the floppy driver still worked we=
=20
> didn't have wifi, I think.

At least we only had old wi-fi extensions [btw, wi-fi =3D=3D wireless netwo=
rks].
I currently tried to run it with 2.4.18 and it works mostly, only when tryi=
ng
to boot on the other P133 system [as described in my other mail], the system
only hangs.

> Someone just has to adopt floppy to the new vfs=20
> api, and we'll be happy. However, most of us are into different things,=
=20
> and some of us don't even have a floppy.

Most of my computers even have 2 floppies [my old boss gave them out for
free and I thought copying directly would be fast...which is just false!
Copying directly with one FDC is about 20 times slower! Possibly a problem
with out floppy driver ?]

> > I am still hoping that in 2.5.31/32 floppy and apm will work again.
>=20
> unlikely(eGiven someone cares)...

seems like lkml consists of more people using apples without FDC :(

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9TL7DtnlUggLJsX0RAntKAJ9ZtYL/NrAL5ifKzd4N61UoJ1bD+wCdHJtd
gcMzvEDBK2A5roZVS7geTXc=
=f5zU
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
