Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTKXIa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 03:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTKXIa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 03:30:26 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:1920 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263662AbTKXIaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 03:30:21 -0500
Subject: Re: Kernel oops at boot with 2.6.0-test9, 2.4.21ELsmp on Opteron
	248
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Paul Venezia <pvenezia@ininet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1069453947.3807.2341.camel@soul.jpj.net>
References: <1069453947.3807.2341.camel@soul.jpj.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tSJT0NAJTlsJ9J2Dh8MG"
Organization: Red Hat, Inc.
Message-Id: <1069497027.6256.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 22 Nov 2003 11:30:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tSJT0NAJTlsJ9J2Dh8MG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-11-21 at 23:32, Paul Venezia wrote:
> I meant to include more complete traces in my previous post, but I'm
> having some odd problem with serial consoles on this box so I only get
> partial clean output. Here's what I can gather at the moment:
>=20

this may be a case of "the" bios bug; could you try passing "idle=3Dpoll"
to the kernel ?
If that helps you need a newer bios....


--=-tSJT0NAJTlsJ9J2Dh8MG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/vzrDxULwo51rQBIRAniPAJ4mVm2tVLWer6t6sMt5AF5AIi/FegCfQPMF
teNUKENcB4fW4BbZNT0VIFA=
=bMWe
-----END PGP SIGNATURE-----

--=-tSJT0NAJTlsJ9J2Dh8MG--
