Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270028AbTGMAI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270029AbTGMAI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 20:08:57 -0400
Received: from maila.telia.com ([194.22.194.231]:37622 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S270028AbTGMAI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 20:08:56 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Subject: Re: [2.7.75] Misc compiler warnings
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: linux-kernel@vger.kernel.org
In-Reply-To: <1058053975.12250.2.camel@sm-wks1.lan.irkk.nu>
References: <1058053975.12250.2.camel@sm-wks1.lan.irkk.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uMKG2o+jwbKgqzuIInWm"
Organization: LANIL
Message-Id: <1058055803.12256.27.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 02:23:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uMKG2o+jwbKgqzuIInWm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-13 at 01:52, Christian Axelsson wrote:
> Here are some compiler warnings:
>=20
>   CC      drivers/i2c/i2c-dev.o
> drivers/i2c/i2c-dev.c: In function `show_dev':
> drivers/i2c/i2c-dev.c:121: warning: unsigned int format, different type
> arg (arg 3)
>=20
>   CC      drivers/usb/core/file.o
> drivers/usb/core/file.c: In function `show_dev':
> drivers/usb/core/file.c:96: warning: unsigned int format, different type
> arg (arg 3)
>=20
>   AS      arch/i386/boot/setup.o
> arch/i386/boot/setup.S: Assembler messages:
> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> 0x37ffffff

Ehm sorry, I should say that this is 2.5.75-mm1

On 2.5.75-vanilla only the AS message occour.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-uMKG2o+jwbKgqzuIInWm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EKZ7yqbmAWw8VdkRAqs4AKCboFIWdCnutrOX7IC1di6IKt/xlQCgsVwB
kkc0e9ACZuz6lf+l1khLSfk=
=KGS0
-----END PGP SIGNATURE-----

--=-uMKG2o+jwbKgqzuIInWm--

