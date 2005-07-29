Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVG2Auq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVG2Auq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG2Auq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:50:46 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:3032 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S262255AbVG2Aun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:50:43 -0400
Date: Fri, 29 Jul 2005 02:50:34 +0200
From: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3 question
Message-Id: <20050729025034.2b58d34e.astralstorm@gorzow.mm.pl>
In-Reply-To: <20050728204238.GC4790@stusta.de>
References: <20050728194334.4f5b3f22.astralstorm@gorzow.mm.pl>
	<20050728105551.57f3183c.akpm@osdl.org>
	<20050728203133.0a03dbda.astralstorm@gorzow.mm.pl>
	<20050728204238.GC4790@stusta.de>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__29_Jul_2005_02_50_34_+0200_U_i_uS76D68QoEoq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__29_Jul_2005_02_50_34_+0200_U_i_uS76D68QoEoq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jul 2005 22:42:38 +0200
Adrian Bunk <bunk@stusta.de> wrote:


> I'm surprised that you are that much concerned about compile errors when=
=20
> using a kernel that might regularly exchange the contents of /dev/hda=20
> and /dev/null .
>=20
These bugs don't happen too often in reality.
Just please don't be malicious and add this kind of code deliberately. :)

Every build breaker wastes my precious time to fix it.=20
That's compulsive/obsessive in some way. ;)

On the contrary, my "just break it" desktop is destined to have
it's HDD contents overwritten once in a time.
That's what these spare disks/computers are for, aren't they?
All the data on that computer is volatile, all (not too frequent) backup is
mostly made through the network and checked from the stable computer.

If I really needed it very stable, I wouldn't test Reiser4 on it, less so
a development kernel. That's why my stable machine uses latest release kern=
el,
and only after it's broken in by at least a week.

--=20
AstralStorm

GPG Key ID =3D 0xD1F10BA2
GPG Key fingerprint =3D 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2
Please encrypt if you can.

--Signature=_Fri__29_Jul_2005_02_50_34_+0200_U_i_uS76D68QoEoq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFC6X1glUMEU9HxC6IRAsSxAKCmsA5nKHftrFJKUG+esb+IKiEwkACbBNtx
GedRBrZzyhjRQDwnEcuectI=
=lXKl
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Jul_2005_02_50_34_+0200_U_i_uS76D68QoEoq--
