Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270760AbTGUXoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270762AbTGUXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 19:44:11 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:59299 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S270760AbTGUXoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 19:44:09 -0400
Subject: Re: [2.6.0-test1] Unable to handle kernel NULL pointer dereference
	at virtual address 00000324
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <ramon.rey@hispalinux.es>
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030721223126.36712.qmail@web13304.mail.yahoo.com>
References: <20030721223126.36712.qmail@web13304.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4FLClmXigDNJHvznK8Dm"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1058831951.8576.4.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 01:59:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4FLClmXigDNJHvznK8Dm
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El mar, 22-07-2003 a las 00:31, Ronald Jerome escribi=F3:
> That is the exact same Oops I get.  I wasunable to
> catpure or print it because the kernel locks up.
>=20
> How were you are ble catch the Oops message if yoru
> system froze?

My system work well :) after the Oops I got, not frozen, but with the
kernel option=20

CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy

you can try to recover information about crashes
--=20
/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\
| Ram=F3n Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/

--=-4FLClmXigDNJHvznK8Dm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HH5PRGk68b69cdURAqd2AJ48q8Y2PgRtvYa+8nmXFCxSfGiIdQCfTKZT
w4iblfbvqKyZs/0z85NOcDU=
=X1lN
-----END PGP SIGNATURE-----

--=-4FLClmXigDNJHvznK8Dm--

