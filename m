Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbTLZIWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 03:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLZIWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 03:22:08 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:28888
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264971AbTLZIWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 03:22:04 -0500
Date: Fri, 26 Dec 2003 00:22:01 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-mm1 oops from khubd
Message-ID: <20031226082201.GA2853@firesong>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031223071327.GG7522@triplehelix.org> <20031224175130.GA30182@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20031224175130.GA30182@kroah.com>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2003 at 09:51:30AM -0800, Greg KH wrote:
> Ick, I thought we had fixed this...
>=20
> Can you try the patch below?  It should apply on top of the -mm1 tree
> you are using.  Let me know if this fixes the problem or not.

Well, I can no longer reproduce this problem on my end, even with the
old kernel. I've applied it though and I'll buzz you if it happens
again.

--=20
Joshua Kwan

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+vvqaOILr94RG8mAQIhEBAAkAWkLiZn3VftV1bPVu9xGMm1N+mSHZyz
zWc+5ysupKwTMhYvSRQ1WHYaGw7NzUUwCnM+uqp+FhXmqofOfxXSSnRwRe5+AC9s
cfFJs4B0bVNyrxnVOnc/8XLyG6/w6hSA5Qxow35thPxjJHetkZWEfQeYVg0Al9Yg
NQ5XnxxFB8u1oKbL46Wl8gLexf8DPb6xzB3bQ+8MwGSEuo1g9marF5PVIpn+6si6
XY5zeUlftwj4VVbmURv2haLp488D/YR4RnuYkcHnVe/pVy/YG3l/0/trlJPj++KZ
UwTwVFAi6gDUB09A2g9cN2uavJ3vIJZw+RWjdXtxVYo7R8POCcoJXzNJXWl7c/TN
OrHn3K4D7mTF+uAsH7o+RHCnl2QOv+Quz1Yn5/ijaiue7NdIK1c1opipWrlNaRhA
9rTiL5oa28Bni5lY1aUdZXGf0Hu09zL+1kUXHc+Kyx0tawalP4/GL4Z/KXwPva2e
Ofhk6QYu0S/stA+SdtGWjJpQgxnj4+00e5ACioAr6R+b6WygxBnhkwSvjMqZx088
/ut7Z9xW/ZhnkAhgV+5M5oiDJRGewP4ZGh4LVqvq0Y1VEPAOEA0M6QS7khiIKdGi
pMFsX/Z70ueuuq/P1tWRiR/S4D0dR7BkjyYlmBsCb8t2qfgqmZqCGtkWlEg9Vkkd
Szf/L27XY60=
=Ppb4
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
