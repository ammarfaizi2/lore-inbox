Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTLCBJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTLCBJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:09:30 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:26243
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264467AbTLCBJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:09:27 -0500
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Ian Kumlien <pomac@vapor.com>
To: Allen Martin <AMartin@nvidia.com>
Cc: b@netzentry.com, ross.alexander@uk.neceur.com, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, cbradney@zip.com.au, forming@charter.net
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F86B@mail-sc-6.nvidia.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F86B@mail-sc-6.nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kCbXzhYLInqH3ahH3B2b"
Message-Id: <1070413766.1766.26.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 02:09:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kCbXzhYLInqH3ahH3B2b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-03 at 01:58, Allen Martin wrote:
> > -----Original Message-----
> > From: Ian Kumlien [mailto:pomac@vapor.com]=20
> > Sent: Tuesday, December 02, 2003 4:47 PM

> =20
> > Well, IDE is what i'd blame. My original experience about lost
> > interrupts leads me to ide. Since i never loose interrupts without
> > io-apic.
>=20
> Can someone who has a system showing this problem try booting from a PCI =
IDE
> card to see if it makes any difference?  I'd try the experiemnt here, but=
 I
> can't reproduce the hanging that's being reported.

Or just to verify boot a kernel without the nvidia/amd ide driver and
io-apic enabled.

--=20
Ian Kumlien <pomac@vapor.com>

--=-kCbXzhYLInqH3ahH3B2b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zTfG7F3Euyc51N8RAunYAJ9dPlqSAOKTAbEN64wuoaJmoXjMaQCeJ86l
F/rwf2d+1H/dEOz9vXi3yao=
=0MqI
-----END PGP SIGNATURE-----

--=-kCbXzhYLInqH3ahH3B2b--

