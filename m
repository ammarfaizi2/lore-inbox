Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUABUJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUABUJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:09:25 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:62926 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265636AbUABUJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:09:18 -0500
Date: Fri, 2 Jan 2004 21:09:17 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
Message-ID: <20040102200917.GD14285@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031231073101.A474@beton.cybernet.src> <20031231211101.68ba1362.pj@sgi.com> <20040101174845.GB2022@gtf.org> <20040102170402.GD5731@helium.inexs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20040102170402.GD5731@helium.inexs.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-02 11:04:02 -0600, Chuck Campbell <campbell@accelinc.com>
wrote in message <20040102170402.GD5731@helium.inexs.com>:
> On Thu, Jan 01, 2004 at 12:48:45PM -0500, Jeff Garzik wrote:
> >=20
> > For a network driver, nVidia will have a really tough time convincing me
> > there is useful IP in their NIC driver, or the NIC itself :)  There are
> > much more advanced NICs out there (with public docs, no less)...
>=20
> Where might one look to find a list of these, for system planning purpose=
s?

Personally, I like to buy tulip based cards. One you might easily get is
the KTI KT-320 (or was it KF-320? Both exist, one is el-cheapo, the good
one is at about 40..50 EUR or US-$).

Some time ago, I also used eepro100-based cards. But since Intel has
started to put these into their chipset (as it seems with some
additional silicone bugs, which freezes the box with eepro100, but not
with working-around Intel's e100 driver) I don't use them any longer...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9c/tHb1edYOZ4bsRArRlAJ92Cd4Ps4XAkj5P9UQK75+4Dxpm6wCbBvNa
PHv1E0TxyO5jHthksWw6do4=
=1bi9
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
