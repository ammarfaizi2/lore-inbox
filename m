Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTECPSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTECPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:18:36 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:33931 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S263336AbTECPSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:18:35 -0400
Subject: Re: Compile error kernel 2.4.20-rc1
From: Anders Karlsson <anders@trudheim.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200305030943.h439h41I015669@post.webmailer.de>
References: <20030503051007$7bb4@gated-at.bofh.it>
	 <200305030943.h439h41I015669@post.webmailer.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RCn6+JsoRa6wIMLuHzR/"
Organization: Trudheim Technology Limited
Message-Id: <1051975854.2831.54.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 03 May 2003 16:30:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RCn6+JsoRa6wIMLuHzR/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good Afternoon,

On Sat, 2003-05-03 at 10:40, Arnd Bergmann wrote:
>=20
> Try this one. Note that you can use 'make -k vmlinux modules' to find
> all the broken files in one run.

Many thanks for the patch, I have applied it, but I still ended up with
compile time errors elsewhere in the wan drivers. I ended up minimising
the configuration to eliminate the parts with errors. I will go through
and document all breaks in one go once I have got the other bits I need
to do out of the way.

/Anders

--=-RCn6+JsoRa6wIMLuHzR/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+s+CuLYywqksgYBoRAnnzAJsHxRkQHJ9urQdmoZu6NUuR0NJiFQCdH/dB
QYSaONGs74T9cZra2GwfTnw=
=uVFN
-----END PGP SIGNATURE-----

--=-RCn6+JsoRa6wIMLuHzR/--

