Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVGIRGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVGIRGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 13:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGIRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 13:06:54 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.83]:64457 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261621AbVGIRGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 13:06:48 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <20050708145953.0b2d8030.akpm@osdl.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lZiJE5sCrp1esK5wcb6D"
Date: Sat, 09 Jul 2005 19:08:11 +0200
Message-Id: <1120928891.17184.10.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lZiJE5sCrp1esK5wcb6D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-08 at 14:59 -0700, Andrew Morton wrote:
> Chris Wedgwood <cw@f00f.org> wrote:

> > WHAT?
> >=20
> > The previous value here i386 is 1000 --- so why is the default 250.
>=20
> Because 1000 is too high.
>=20

What happened to 300 as default, as that is divisible by both 50 and 60
(or something like that) ?  Wanted to remember somebody suggested rather
using that ...  Curiosity sake.


Thanks,

--=20
Martin Schlemmer


--=-lZiJE5sCrp1esK5wcb6D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0AR7qburzKaJYLYRAsIDAJ9jNq5zvLK9XeTKRV02b1Kwy6aY6wCfcYZg
FJe1/uX8OtB/k4HpvE18QRQ=
=uCkh
-----END PGP SIGNATURE-----

--=-lZiJE5sCrp1esK5wcb6D--

