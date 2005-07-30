Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVG3IeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVG3IeM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 04:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVG3IeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 04:34:11 -0400
Received: from mx2.mail.ru ([194.67.23.122]:58207 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262700AbVG3IeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 04:34:10 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Date: Sat, 30 Jul 2005 12:33:38 +0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart37431379.Mi5hVze8Ng";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507301233.45901.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart37431379.Mi5hVze8Ng
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> >After downloading and compiling the latest version 2.6.12, my
> >keyboard becomes unresponsive and dead following the boot process.
>=20

=46WIW I have similar problem with Toshiba Portege 4000. Every second reboo=
t=20
keyboard is not there. It is really not there - i.e. I cannot even enter BI=
OS=20
setup or boot menu.

This is not limited to Linux - I had exactly the same problem when WinXP wa=
s=20
on this system.

As in other cases, disabling ACPI helps in this particular case but as this=
=20
system does not have APM it is not a real option.

While I am not very bothered by this problem (I just took habit to switch=20
system off instead of reboot - it takes exactly the same amount of time=20
because reboot seems to *do* switch off and then on) I am open to any=20
suggestion how to debug the issue,

Adding i8042.nomux did not help BTW.

=2Dandrey

--nextPart37431379.Mi5hVze8Ng
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC6ztpR6LMutpd94wRAo9kAJ922MMxZo7u4opV9PxBHrBzTgFGjACg0/7T
ylhgQqTJ90N4/3rIgyAeuzo=
=QsZW
-----END PGP SIGNATURE-----

--nextPart37431379.Mi5hVze8Ng--
