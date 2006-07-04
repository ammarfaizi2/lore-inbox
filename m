Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWGDBig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWGDBig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGDBig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:38:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32863 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751200AbWGDBig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:38:36 -0400
Date: Mon, 03 Jul 2006 21:36:33 -0400
From: Jeff Bailey <jbailey@ubuntu.com>
Subject: Re: [klibc] klibc and what's the next step?
In-reply-to: <20060703184647.GA14100@baikonur.stro.at>
To: maximilian attems <maks@sternwelten.at>
Cc: Rob Landley <rob@landley.net>, klibc@zytor.com,
       Jeff Garzik <jeff@garzik.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       torvalds@osdl.org, "H. Peter Anvin" <hpa@zytor.com>
Message-id: <1151976993.2547.27.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-YJTwiYtJyQergVIGlhPY"
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
 <44A16E9C.70000@zytor.com> <Pine.LNX.4.64.0606290156590.17704@scrub.home>
 <200607031430.47296.rob@landley.net> <20060703184647.GA14100@baikonur.stro.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YJTwiYtJyQergVIGlhPY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le lundi 03 juillet 2006 =C3=A0 20:46 +0200, maximilian attems a =C3=A9crit=
 :
> well but busybox is big nowadays and generally compiled against glibc.
> i'm quite eager to kick busybox out of default Debian initramfs-tools
> to have an klibc only default initramfs. those tools are needed atm,
> and there is not enough yet. afaik suse adds sed on klibc with a minimal
> patch and we'd liked to have stat, kill and readlink on klibc-utils.
>=20
> how about busybox on klibc?

I made a brief attempt to do busybox on klibc before klcc was working
right for me.  I should try that again.  In Ubuntu, we already do a
separate build pass of busybox to get just the features that we want, it
would be easy to play with this.

I'll let you know.  It'll take me a couple days - between travelling and
the long weekend, I'm a bit behind.

Tks,
Jeff Bailey

--=20
* Canonical Ltd * Ubuntu Service and Support * +1 514 691 7221 *

Linux for Human Beings.

--=-YJTwiYtJyQergVIGlhPY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqcYhkNAc0s37a3gRAjOkAKCLeCw8//yRXB4WrQwC0fb+asAIfQCgj36d
zApmKRyM/WX6If+FjTfGrm8=
=YLR/
-----END PGP SIGNATURE-----

--=-YJTwiYtJyQergVIGlhPY--

