Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936413AbWK3N5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936413AbWK3N5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 08:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936414AbWK3N5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 08:57:12 -0500
Received: from fysh.org ([83.170.75.51]:15846 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S936413AbWK3N5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 08:57:11 -0500
Date: Thu, 30 Nov 2006 13:57:09 +0000
From: Athanasius <link@miggy.org>
To: spynet@usa.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A Big bug with ethernet card
Message-ID: <20061130135709.GC4472@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>, spynet@usa.com,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20061128142950.67A461BF297@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NctWKJLgDreUm1FS"
Content-Disposition: inline
In-Reply-To: <20061128142950.67A461BF297@ws1-1.us4.outblaze.com>
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NctWKJLgDreUm1FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2006 at 11:29:50AM -0300, spynet@usa.com wrote:
>                  Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet C=
ontroller=20
>=20
> There are problems with ethernet card when booting to different system, e=
=2Eg. from linux to M$ win - system is not able to connect to network. inst=
ead of re-boot you have to shutdown box and after that turn on.=20

  Check for an upgraded driver for the NIC in windows.

  I had just this problem and just before posting to linux-kernel I
discovered the problem was actually in the windows driver.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--NctWKJLgDreUm1FS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFbuM1Ir2uvLNOS8MRApG0AJ9+9uIxxDjDqpLjpuvdxyLH+jW01gCeODCP
0DvkEshM4Hxe9VBaB4RbwP8=
=KZ8z
-----END PGP SIGNATURE-----

--NctWKJLgDreUm1FS--
