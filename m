Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUHJWFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUHJWFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUHJWFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:05:19 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:2037 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S267766AbUHJWFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:05:10 -0400
Subject: Re: The prune_dcache saga, truely epic proportions now
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: gene.heskett@verizon.net
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200408031421.58487.gene.heskett@verizon.net>
References: <200408031421.58487.gene.heskett@verizon.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T46NH+FlrOY1CEw8owCs"
Message-Id: <1092172017.8976.36.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 23:06:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T46NH+FlrOY1CEw8owCs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-03 at 20:21, Gene Heskett wrote:
> Greetings;
>=20
> This machine has repeatadly passed memtest86-3a for as many as a dozen=20
> full passes without errors.
>=20
> Running 2.6.8-rc2-mm2 which is an improvement, I almost got a 24 hour=20
> uptime.  BUT, it just went away again while trying to run the FC2=20
> version of up2date.
>=20
> A trimmed log, and my .config are attached, please, can someone look=20
> at this?  I can also supply objdumps of the dcache.o file, and a=20
> marked ((#asm "nop #char") style) up dcache.s file if you can tell me=20
> where to put the markups.

If not resolved yet - have you tried yet to disable 4K stacks ?
Might not be related but can't hurt?

--=20
Martin Schlemmer

--=-T46NH+FlrOY1CEw8owCs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGTjxqburzKaJYLYRAmJwAJ9zuwgcsZ4IJBu47Vk5SGv7bxJc5gCfc7JI
WhcfGodirIWNcp8U+Fd31ZE=
=aoTX
-----END PGP SIGNATURE-----

--=-T46NH+FlrOY1CEw8owCs--

