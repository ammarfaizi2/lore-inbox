Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFTEZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFTEZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 00:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVFTEZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 00:25:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:35463 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261420AbVFTEZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 00:25:11 -0400
X-Authenticated: #815327
Message-ID: <42B6451F.4090802@gmx.de>
Date: Mon, 20 Jun 2005 06:25:03 +0200
From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: wake on lan broken in 2.6.12-rc{5,6}
References: <42A86DBB.1010708@gmx.de>
In-Reply-To: <42A86DBB.1010708@gmx.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig78BF4E80905A371EF7E06731"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78BF4E80905A371EF7E06731
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Malte Schr=F6der wrote:
> Hi,
> I tried kernel 2.6.12-rc{5,6} and the machine doesn't wake up on
> MagicPacket any more. It works fine with 2.6.11.x.
> The mobo is a MSI KM4M-V (via km400 with onboard via rhine).
> The link LED stays on when the machine is shut down, so the nic seems t=
o
> be in the right mode.
>=20

Problem is solved in 2.6.12 ...


--=20
---------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------



--------------enig78BF4E80905A371EF7E06731
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCtkUj4q3E2oMjYtURAqGfAJ9ccPKpsPMDaUrCF/OzcwM2uQUF/QCg40Jk
ivfUtovkgPnW/V/a5n8VbLY=
=6x/z
-----END PGP SIGNATURE-----

--------------enig78BF4E80905A371EF7E06731--
