Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTLDQcY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTLDQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:32:24 -0500
Received: from [213.228.188.253] ([213.228.188.253]:40397 "EHLO tuxslare.org")
	by vger.kernel.org with ESMTP id S262694AbTLDQcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:32:22 -0500
Subject: support for Hermes II on the kernel
From: =?ISO-8859-1?Q?Andr=E9?= Ventura Lemos <tux@tuxslare.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5R5snjlGJhTpA6l+kKCt"
Message-Id: <1070555316.3586.6.camel@lapy.tuxslare.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 16:28:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5R5snjlGJhTpA6l+kKCt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Agere Systems Inc. has released the source code for the Hermes II cards
made by Agere. Among them you can find:

    * "Wireless PC Card Model 0104" ("Gold" and "Silver")
    * "Wireless PC Card Model 0106" ("Gold" and "Silver")
    * "Wireless Integrated Card Model 0202"
    * "Wireless Embedded Card Model 0504" (MiniPCI)
    * "Wireless PC Card Model 0110"
    * "Wireless PC Card Model 0111"
    * "Wireless MiniPCI Card Model 0506"
    * "Wireless MiniPCI Card Model 0508"
    * "Wireless CompactFlash Card Model 1401"
    * Other wireless adapters based on Agere's Hermes-I/Hermes-II
chipset.


The license is very similar to GPL (can use it, but must mention who did
it, in this case Agere).

So can this driver be integrated into the 2.6 series? That would be
really nice, as their code ATM only compiles on <=3D2.4, and the new
Proxim Orinoco PC Cards now uses this chip (mine is an Proxim Orinoco
Silver PC Card).

The source code for the drivers can be found here:
http://www.agere.com/support/drivers/index.html


Thanks


Ps.: please do CC me


--=20
Lego my ego, and I'll lego your knowledge

--=-5R5snjlGJhTpA6l+kKCt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/z2C0duWuN7ka4fkRAqHYAJwNZS97Lb7gb6QR8SmXJZIlFIvC0wCgvQ6l
8jtEvbDWeWisqviaiHK0yDQ=
=q37q
-----END PGP SIGNATURE-----

--=-5R5snjlGJhTpA6l+kKCt--

