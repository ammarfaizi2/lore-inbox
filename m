Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162875AbWLBJs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162875AbWLBJs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 04:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162876AbWLBJs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 04:48:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:29316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1162875AbWLBJsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 04:48:55 -0500
X-Authenticated: #815327
From: Malte =?iso-8859-15?q?Schr=F6der?= <MalteSch@gmx.de>
To: David Miller <davem@davemloft.net>
Subject: Re: Linux 2.6.19
Date: Sat, 2 Dec 2006 10:48:48 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
References: <20061129151111.6bd440f9.rdunlap@xenotime.net> <20061129.181537.38322733.davem@davemloft.net> <200611302130.23556.MalteSch@gmx.de>
In-Reply-To: <200611302130.23556.MalteSch@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1194016.WnslNtgVCP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612021048.51880.MalteSch@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1194016.WnslNtgVCP
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 30 November 2006 21:30, Malte Schr=F6der wrote:
> I also encountered this bug (wasn't there in -rc6). The patch also fixes =
it
> for me.

Ok, I have to make a correction here: It doesn't crash anymore but now ipv6=
=20
doesn't work at all. To be more precise, I see adresses on the network=20
interfaces and the corresponding routes, but when I try to ping my gateway =
I=20
get "Destination unreachable: Address unreachable".

Hope this helps ..
=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart1194016.WnslNtgVCP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcUwD4q3E2oMjYtURArEvAKDyocytr7mihjlkSLThnrxdn8x/ywCg1c6u
R+JQAqPL/xbhnYWfdmnp7Cg=
=52xZ
-----END PGP SIGNATURE-----

--nextPart1194016.WnslNtgVCP--
