Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTL3BVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTL3BVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:21:04 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:15041 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262353AbTL3BVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:21:01 -0500
Subject: Re: 2.6.0 performance problems
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
	 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
	 <Pine.LNX.4.58.0312291803420.5835@localhost.localdomain>
	 <1072741422.25741.67.camel@nosferatu.lan>
	 <Pine.LNX.4.58.0312291913270.5835@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HgB+wMuMNuqxZ7lDC8i7"
Message-Id: <1072747404.25741.69.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 03:23:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HgB+wMuMNuqxZ7lDC8i7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-30 at 02:17, Thomas Molina wrote:
> On Tue, 30 Dec 2003, Martin Schlemmer wrote:
>=20
> > >  UDMA modes: udma0 udma1 *udma2 udma3 udma4
> > >  AdvancedPM=3Dyes: mode=3D0x80 (128) WriteCache=3Denabled
> > >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
> > >=20
> > >  * signifies the current active mode
> >=20
> > Any reason it is currently set to udma2 where it support udma4 ?
>=20
> Not really.  The question was what mode the disk was running in.  This is=
=20
> what it defaults to.  This is a laptop drive that only runs at 5400RPM. =20
> Would changing the mode to udma4 make a dramatic difference? =20

Well, should make some.

--=20
Martin Schlemmer

--=-HgB+wMuMNuqxZ7lDC8i7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/8NOMqburzKaJYLYRAgEJAKCJLK9E0Q4j4adfpAI22F0EOKRi5gCePNcX
ZaKnZqNWEuu7xACsKY0iK8U=
=IUdP
-----END PGP SIGNATURE-----

--=-HgB+wMuMNuqxZ7lDC8i7--

