Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVDBVst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVDBVst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVDBVgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:36:25 -0500
Received: from lug-owl.de ([195.71.106.12]:37606 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261373AbVDBVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:20:21 -0500
Date: Sat, 2 Apr 2005 23:20:20 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove all kernel bugs
Message-ID: <20050402212020.GC21175@lug-owl.de>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050401090744.GD15453@waste.org> <20050401091750.GS21175@lug-owl.de> <Pine.LNX.4.62.0504022301190.812@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ix2jQZQ3wXOip0b1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504022301190.812@numbat.sonytel.be>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ix2jQZQ3wXOip0b1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-04-02 23:03:14 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <Pine.LNX.4.62.0504022301190.812@numbat.sonytel.be>:
> On Fri, 1 Apr 2005, Jan-Benedict Glaw wrote:
> > Well, the patch looks fine, but you forgot to also do the VAX-specific
> > part. Withoug the BUGs, maybe the VAX kernel would be even faster?
>=20
> Perhaps it's a good idea to get Linux/VAX merged in mainline first? After=
 that
> people will start fixing all your bugs automagically ;-)

Maybe we'll work on that, but first we need to get real, up-to-date
userspace and not all this old stuff with uClibc. But we're working on
this. (Currently tracking down an ICE. GCC is fun. A lot of fun and
black magic...)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Ix2jQZQ3wXOip0b1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCTwyUHb1edYOZ4bsRAhrhAJ49yEx3SqpeOAD6ZXdSBHkhRGi2jwCbB2kF
hH3msNdA0xrzSrTfcPSe7ag=
=O4v0
-----END PGP SIGNATURE-----

--Ix2jQZQ3wXOip0b1--
