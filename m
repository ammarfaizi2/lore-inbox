Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWB1MMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWB1MMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWB1MMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:12:18 -0500
Received: from mout1.freenet.de ([194.97.50.132]:4808 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932509AbWB1MMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:12:17 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Generic hardware RNG support
Date: Tue, 28 Feb 2006 13:11:59 +0100
User-Agent: KMail/1.8.3
References: <200602281229.12887.mbuesch@freenet.de> <44043CEE.70201@pobox.com>
In-Reply-To: <44043CEE.70201@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1224260.4fLTGaItBb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602281311.59888.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1224260.4fLTGaItBb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 28 February 2006 13:07, you wrote:
> Michael Buesch wrote:
> > Andrew, consider inclusion of the following patch into -mm
> > for further testing, please.
> >=20
> > ---
> >=20
> > This patch adds support for generic Hardware Random Number Generator
> > drivers. This makes the usage of the bcm43xx internal RNG through
> > /dev/hwrandom possible.
> >=20
> > A patch against bcm43xx for your testing pleasure can be found at:
> > ftp://ftp.bu3sch.de/misc/bcm43xx-d80211-hwrng.patch
>=20
> Please merge with Deepak Saxena's generic RNG stuff, rather than=20
> duplicating efforts.

Well, I did not know that someone else already wrote something
like this. Do you have any pointers to his stuff (patches)?

=2D-=20
Greetings Michael.

--nextPart1224260.4fLTGaItBb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEBD4Plb09HEdWDKgRAvdBAKCVFpAIsrN4P0O/SGa3SgqjGg9P+QCaAzz4
lK3lT4hf88Df4WeqF48HcD8=
=fnq3
-----END PGP SIGNATURE-----

--nextPart1224260.4fLTGaItBb--
