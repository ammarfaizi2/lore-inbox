Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267005AbTGGNR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267006AbTGGNR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:17:58 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:22286 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S267005AbTGGNRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:17:54 -0400
Subject: Re: kernel oops
From: Anders Karlsson <anders@trudheim.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1057583643.2743.38.camel@dhcp22.swansea.linux.org.uk>
References: <1057582393.2034.13.camel@tor.trudheim.com>
	 <1057583643.2743.38.camel@dhcp22.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b1B2xfSBNJj2Yy1dwIg4"
Organization: Trudheim Technology Limited
Message-Id: <1057584747.2278.17.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 07 Jul 2003 14:32:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b1B2xfSBNJj2Yy1dwIg4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-07 at 14:14, Alan Cox wrote:
> On Llu, 2003-07-07 at 13:53, Anders Karlsson wrote:
> > Running a compile of kernel 2.4.22-pre3 with FreeS/WAN 2.0.1 patches
> > applies generates oops in __free_pages_ok which in turn leads to a
> > completely unusable system shortly afterwards.
>=20
> Can you replicate this without the freeswan patches out of interest ?

The running kernel is 2.4.21-rc7-ac1, I was trying to compile
2.4.22-pre3 with the freeswan patches applied. I can try and
compile the plain 2.4.22-pre3 a few times to provoke an oops.
The system is presently still running 2.4.21-rc7-ac1.

Will post again once I've run 3-4 compiles.

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-b1B2xfSBNJj2Yy1dwIg4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/CXZrLYywqksgYBoRAiSZAKDUVIMIbyauxQer3ADP+bsHyu39ywCZAQBj
ZXB2mFHu4XqbrKfwQdlNWTc=
=W0nJ
-----END PGP SIGNATURE-----

--=-b1B2xfSBNJj2Yy1dwIg4--

