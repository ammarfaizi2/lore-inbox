Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270023AbTGLXi3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 19:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270024AbTGLXi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 19:38:29 -0400
Received: from maila.telia.com ([194.22.194.231]:5092 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S270023AbTGLXi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 19:38:27 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Subject: [2.7.75] Misc compiler warnings
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IhJCbEqKeGvjk3hENOL+"
Organization: LANIL
Message-Id: <1058053975.12250.2.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 01:52:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IhJCbEqKeGvjk3hENOL+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here are some compiler warnings:

  CC      drivers/i2c/i2c-dev.o
drivers/i2c/i2c-dev.c: In function `show_dev':
drivers/i2c/i2c-dev.c:121: warning: unsigned int format, different type
arg (arg 3)

  CC      drivers/usb/core/file.o
drivers/usb/core/file.c: In function `show_dev':
drivers/usb/core/file.c:96: warning: unsigned int format, different type
arg (arg 3)

  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
0x37ffffff


--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-IhJCbEqKeGvjk3hENOL+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EJ9XyqbmAWw8VdkRAmqFAJ46o+Zq+1VoJ4hetc51GecAd7vvPACeOgI8
szeQ216aWvyM7qSTVtSo8hU=
=zxO9
-----END PGP SIGNATURE-----

--=-IhJCbEqKeGvjk3hENOL+--

