Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUA3Lb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUA3Lb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:31:59 -0500
Received: from 82-68-84-57.dsl.in-addr.zen.co.uk ([82.68.84.57]:57044 "EHLO
	lenin.trudheim.com") by vger.kernel.org with ESMTP id S263491AbUA3Lb5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:31:57 -0500
Subject: Bluetooth oddity
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZTl9MMFOyJKhHasQ91YJ"
Organization: Trudheim Technology Limited
Message-Id: <1075462349.9698.4.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 Rubber Turnip www.usr-local-bin.org 
Date: Fri, 30 Jan 2004 11:32:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZTl9MMFOyJKhHasQ91YJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi list,

Out of curiosity, has anyone else noticed something odd with Bluetooth
in 2.6.x kernels? On my Thinkpad X31 I can switch it on/off with Fn+F5.
Switching it on is no problem, but switching it off causes solid hang of
the Thinkpad. Only SysRq+b works.

It is not the whole world, but a little irritating. Also, I use
Bluetooth to hot-sync my Tungsten T|3. Same problem occurs on the 4th -
6th sync, solid hang of the Thinkpad. No debug output yet, if any
Bluetooth developers are interested to have this fixed, I am game to
help debug this.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-ZTl9MMFOyJKhHasQ91YJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAGkDNLYywqksgYBoRAmI1AKCj0/ezm2CScNvgi6Yx3/95OLP3bACfYQL5
ZPRpYkKLpsyvUns90pzr1vc=
=qfN4
-----END PGP SIGNATURE-----

--=-ZTl9MMFOyJKhHasQ91YJ--
