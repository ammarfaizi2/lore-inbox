Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWB1Lek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWB1Lek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWB1Lek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:34:40 -0500
Received: from mout0.freenet.de ([194.97.50.131]:61828 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S932184AbWB1Lej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:34:39 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: akpm@osdl.org
Subject: Re: [PATCH] Generic hardware RNG support
Date: Tue, 28 Feb 2006 12:34:24 +0100
User-Agent: KMail/1.8.3
References: <200602281229.12887.mbuesch@freenet.de>
In-Reply-To: <200602281229.12887.mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2536620.jxAVoEkMJ8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602281234.24658.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2536620.jxAVoEkMJ8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 28 February 2006 12:29, you wrote:
> Andrew, consider inclusion of the following patch into -mm
> for further testing, please.
>=20
> ---
>=20
> This patch adds support for generic Hardware Random Number Generator
> drivers. This makes the usage of the bcm43xx internal RNG through
> /dev/hwrandom possible.
>=20
> A patch against bcm43xx for your testing pleasure can be found at:
> ftp://ftp.bu3sch.de/misc/bcm43xx-d80211-hwrng.patch

Oops, I forgot:
Signed-off-by: Michael Buesch <mbuesch@freenet.de>

Sorry.

=2D-=20
Greetings Michael.

--nextPart2536620.jxAVoEkMJ8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBDVAlb09HEdWDKgRAn5OAJ4iYBSmBRT3AW4B4ykTQhEfh3ZPpACgn3j3
g2YZUGlzlt/kuiO3ZsDtGFM=
=5I4q
-----END PGP SIGNATURE-----

--nextPart2536620.jxAVoEkMJ8--
