Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUHRNuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUHRNuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHRNuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 09:50:00 -0400
Received: from mail.dsvr.co.uk ([212.69.192.8]:21395 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S265275AbUHRNt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 09:49:57 -0400
Date: Wed, 18 Aug 2004 14:49:59 +0100
From: Jonathan Sambrook <beardie@dsvr.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.05
Message-ID: <20040818134959.GC29311@jsambrook>
References: <20040818125104.GA12286@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20040818125104.GA12286@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 14:51 on Wed 18/08/04, herbert@13thfloor.at masquerading as 'Herbert Poe=
tzl' wrote:
>=20
> Greetings!
>=20
> The following patch extends the 'noatime', 'nodiratime' and
> last but not least the 'ro' (read only) mount option to the
> vfs --bind mounts, allowing them to behave like any other
> mount, by honoring those mount flags (which are silently
> ignored by the current implementation in 2.4.x and 2.6.x)
>=20

What's the likelyhood/timeframe for this getting into mainline kernels?

Cheers,
Jonathan

--=20
                  =20
 Jonathan Sambrook=20
Software  Developer=20
 Designer  Servers

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBI16HSUOTbbpGXDwRAkfWAJ4+0BVpkq6R/5/nOQaJ2FPm7vmIzQCfW2+V
7hGXd6pqi5TxLiD00JCOGBk=
=7D8O
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
