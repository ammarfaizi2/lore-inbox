Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTGKNMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTGKNMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:12:20 -0400
Received: from mailg.telia.com ([194.22.194.26]:62185 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S262127AbTGKNLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:11:31 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: vesa looks messed up again in 2.5.75. No Penguin Logo
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: imunity@softhome.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1057887460.22706.1.camel@sm-wks1.lan.irkk.nu>
References: <courier.3F0E1349.000037B8@softhome.net>
	 <1057887460.22706.1.camel@sm-wks1.lan.irkk.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j+4/hfGjL0YAwBenGvv2"
Organization: LANIL
Message-Id: <1057929938.4437.3.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 15:25:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j+4/hfGjL0YAwBenGvv2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-11 at 03:37, Christian Axelsson wrote:
> On Fri, 2003-07-11 at 03:30, imunity@softhome.net wrote:
> > Works in 2.5.74-mm2 and 2.5.74-mm3=20
> >=20
> > Broken in 2.5.75=20
>=20
> Does James Simmons fbdev fix it?
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>=20
> Note that I havent tried it against 2.5.75 (yet) so I dont even know if
> it applies.

Ok it applies fine but I havent booted it but it should fix the messedup
bootlogo.

2.5.75-mm1 that has this included works fine (as usual)

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-j+4/hfGjL0YAwBenGvv2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/DrrSyqbmAWw8VdkRAobQAKCCXd2X4+8jMZyv+W4N+ewZbTp7cgCfbGU9
Nq5OUVR93QgoLQWw3Osy36s=
=UFvG
-----END PGP SIGNATURE-----

--=-j+4/hfGjL0YAwBenGvv2--

