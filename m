Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbUJYJlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbUJYJlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUJYJlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:41:47 -0400
Received: from mout0.freenet.de ([194.97.50.131]:35297 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261740AbUJYJk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:40:59 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Serious stability issues with 2.6.10-rc1
Date: Mon, 25 Oct 2004 11:39:19 +0200
User-Agent: KMail/1.7
References: <pan.2004.10.25.01.20.55.763270@triplehelix.org>
In-Reply-To: <pan.2004.10.25.01.20.55.763270@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1813164.inC6sMoWk2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410251139.24509.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1813164.inC6sMoWk2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Joshua Kwan <joshk@triplehelix.org>:
> Hello,
>=20
> 2.6.10-rc1 seems to have a tendency to lock up after about 8 hours or so
> of uptime. Usually, I am in X, listening to music, and working on
> something when this happens out of the blue. It's a hard hang and there is
> no network response or ability to switch back to a tty so i can get
> sysrq-t output. It just dies. This has happened twice in the past 48 or
> so hours.
>=20
> I can't really provide much debugging info though, due to the nature of
> the hang. Is there anything that pops into mind that I should try to nail
> this problem?
>=20
> 2.6.9 seems to be a lot better at staying alive.

I saw exactly the same problem in 2.6.9-rcX and 2.6.9.
I didn't try 2.6.10-rc1, yet.
The last stable kernel was 2.6.8.1 for me.

> Thanks
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart1813164.inC6sMoWk2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBfMnMFGK1OIvVOP4RAryDAKDDpBX0QmdCFRuPwoOO+2aJ4R3JWgCfdJBX
h3rO+rUC0QOWpbpKvdFXE7Q=
=ugnn
-----END PGP SIGNATURE-----

--nextPart1813164.inC6sMoWk2--
