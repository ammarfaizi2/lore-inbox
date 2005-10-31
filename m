Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVJaQ1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVJaQ1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVJaQ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:27:31 -0500
Received: from mout1.freenet.de ([194.97.50.132]:34987 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932453AbVJaQ1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:27:30 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Nix <nix@esperi.org.uk>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Mon, 31 Oct 2005 17:27:09 +0100
User-Agent: KMail/1.8
References: <20051030105118.GW4180@stusta.de> <20051030194951.GJ4180@stusta.de> <87wtjt7k55.fsf@amaterasu.srvr.nix>
In-Reply-To: <87wtjt7k55.fsf@amaterasu.srvr.nix>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1378600.QjZxExTkND";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510311727.09261.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1378600.QjZxExTkND
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 31 October 2005 16:59, you wrote:
> On 30 Oct 2005, Adrian Bunk said:
> > E.g. it's clear that unused code or unused EXPORT_SYMBOL's in the kerne=
l=20
> > are bloat, so I am working on eliminating such bloat.
>=20
> And thank you very much for that!
>=20
> What's most notable to me is a substantial cross-arch reduction in .data
> space consumed. This non-FUSE-2.6.13 versus FUSE-2.6.14 UltraSPARC
> comparison shows this effect clearly:


> .data.read_mostly             428      13144  -12716
+12716


=2D-=20
Greetings Michael.

--nextPart1378600.QjZxExTkND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDZkXdlb09HEdWDKgRAlhEAJ0aS7xhaqUo8fzvp9ZSYY6fckJS5gCgvQJw
uBXTHz7BWdqh7DWmvHpTHHM=
=nxoh
-----END PGP SIGNATURE-----

--nextPart1378600.QjZxExTkND--
