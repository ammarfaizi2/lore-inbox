Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVB1WjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVB1WjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVB1WjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:39:25 -0500
Received: from smtp.gentoo.org ([134.68.220.30]:22985 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261788AbVB1WjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:39:21 -0500
Subject: Re: Support for GEODE CPU's in Kernel 2.6.10.
From: Henrik Brix Andersen <brix@gentoo.org>
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
Cc: davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0502272255090.1693@merlin.sk-tech.net>
References: <Pine.LNX.4.61.0502272255090.1693@merlin.sk-tech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gVVV4tQwer/pmtth15lN"
Organization: Gentoo Linux
Date: Mon, 28 Feb 2005 23:39:14 +0100
Message-Id: <1109630355.20308.2.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gVVV4tQwer/pmtth15lN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-02-27 at 23:11 +0100, Kianusch Sayah Karadji wrote:
> This is a small patch for GEODE CPU support in Kernel 2.6.10.

I would very much welcome the addition of MGEODE. The in-kernel SCx200
drivers could also benefit from this (they should depend on MGEODE).

Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>

./Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-gVVV4tQwer/pmtth15lN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCI52Sv+Q4flTiePgRAk/CAKClmyxHvjCg3Br6fD7LK+kucsfRAwCdGGBR
V4Yr7BjiAXKXc30PZpVj5zk=
=cFmZ
-----END PGP SIGNATURE-----

--=-gVVV4tQwer/pmtth15lN--

