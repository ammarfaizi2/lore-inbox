Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263337AbUJ2SDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbUJ2SDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbUJ2R7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:59:51 -0400
Received: from fe08.axelero.hu ([195.228.240.96]:50190 "EHLO fe08.axelero.hu")
	by vger.kernel.org with ESMTP id S263438AbUJ2R4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:56:36 -0400
Subject: Re: Latest Microcode data from Intel now available.
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0410281531370.2379@ezer.homenet>
References: <Pine.LNX.4.61.0410281531370.2379@ezer.homenet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-brWBWFK5Wv9uIl/B/2/f"
Message-Id: <1099072587.5649.9.camel@alderaan.trey.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Oct 2004 19:56:27 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030217) (fe08.axelero.hu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-brWBWFK5Wv9uIl/B/2/f
Content-Type: multipart/mixed; boundary="=-lIfQshOmJL5k/xfqzfQj"


--=-lIfQshOmJL5k/xfqzfQj
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi Tigran!

Just a small correction... Patch attached. Tested on Debian Sarge.

2004-10-29, p keltez=E9ssel 17:08-kor Tigran Aivazian ezt =EDrta:
> Hello,
>=20
> The latest (12 Oct 2004) microcode update data file for Intel processors=20
> (x86 and x86_64) is now available from the usual place:
>=20
> http://urbanmyth.org/microcode/

--=20
Micsk=F3 G=E1bor
HP Accredited Platform Specialist, System Engineer (APS, ASE)
Szint=E9zis Computer Rendszerh=E1z Rt.     =20
H-9021 Gy=F5r, Tihanyi =C1rp=E1d =FAt 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
Web: http://www.hup.hu/
GPG Key fingerprint: 6FA1 D8BF 3C73 0570 ED5D  82AC A3BE 4E6A CF95 5F50

--=-lIfQshOmJL5k/xfqzfQj
Content-Disposition: attachment; filename=microcode_ctl.start.diff
Content-Type: text/x-patch; name=microcode_ctl.start.diff; charset=ISO-8859-2
Content-Transfer-Encoding: base64

LS0tIG1pY3JvY29kZV9jdGwuc3RhcnQJMjAwMS0wNi0xMSAxNjozNDowOC4wMDAwMDAwMDAgKzAy
MDANCisrKyBtaWNyb2NvZGVfY3RsLnN0YXJ0XwkyMDA0LTEwLTI5IDE5OjE1OjQ5LjAwMDAwMDAw
MCArMDIwMA0KQEAgLTM2LDcgKzM2LDcgQEANCiAJRU5EPSJyY19zdGF0dXMgLXYiDQogCS4gL2V0
Yy9yYy5jb25maWcNCiAJLiAvZXRjL3JjLnN0YXR1cw0KLWVsaWYgWyAtZiAvZXRjL2RlYmlhbl9y
ZWxlYXNlIF07IHRoZW4NCitlbGlmIFsgLWYgL2V0Yy9kZWJpYW5fdmVyc2lvbiBdOyB0aGVuDQog
CS4gL2V0Yy9kZWZhdWx0L3JjUw0KIAlpZiBbICIkVkVSQk9TRSIgIT0gIm5vIiBdIDsgdGhlbg0K
IAkJRU5EPWRlYmlhbl9lbmQNCg==

--=-lIfQshOmJL5k/xfqzfQj--

--=-brWBWFK5Wv9uIl/B/2/f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ez az =?ISO-8859-1?Q?=FCzenetr=E9sz?=
	=?ISO-8859-1?Q?_digit=E1lis?= =?ISO-8859-1?Q?_al=E1=EDr=E1ssal?= van
	=?ISO-8859-1?Q?ell=E1tva?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBgoRLo75Oas+VX1ARAsLCAJ94+XwCqW5enH+yDsheAzQzF/yAgACbBNBR
wlYBfaDDrijdSzHzdLArj1k=
=YKYX
-----END PGP SIGNATURE-----

--=-brWBWFK5Wv9uIl/B/2/f--

