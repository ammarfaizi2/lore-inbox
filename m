Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTASSrZ>; Sun, 19 Jan 2003 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTASSrZ>; Sun, 19 Jan 2003 13:47:25 -0500
Received: from [216.38.156.94] ([216.38.156.94]:38927 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S262500AbTASSrX>; Sun, 19 Jan 2003 13:47:23 -0500
Subject: Re: A Flightening and Strange experience compiling 2.5.58
From: Dmitri <dmitri@users.sourceforge.net>
To: Sampson Fung <sampson@attglobal.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000001c2bfe9$28bf8340$febca8c0@noelpc>
References: <000001c2bfe9$28bf8340$febca8c0@noelpc>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1+JLqY5vS23ZiTAuZ6hD"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Jan 2003 10:55:43 -0800
Message-Id: <1043002544.1982.564.camel@usb.networkfab.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1+JLqY5vS23ZiTAuZ6hD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-01-19 at 10:32, Sampson Fung wrote:

> Does anyone has similar problems?  That is:  H/W POST do not start after
> machine hangs.

Sure. I have one m/b here that:

a) enters POST only if the planets are in favorable position
b) once running, it sometimes stops unpredictably; then goto a;

I suspect a crack in the m/b, since the RAM was tested in other boxes
and appears to be fine. I already retired this m/b, and it is on its way
to the trash.

Messages that you saw are probably related to some hardware that went
belly up while the box was running, and the code mistook the hardware
failure for some valid condition that only asked for a reset.

Generally, if the box does not enter POST after hard reset then the m/b
or other major components such as RAM or CPU are broken. This is by
definition, because RESET is supposed to reinit all the h/w, and any
memory of the past is not supposed to be there.

Dmitri


--=-1+JLqY5vS23ZiTAuZ6hD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+KvSviqqasvm69/IRApVzAKCfCV+IKcKVT2+wr5KbZSrVjQiU2QCfaIB8
5PGNXKQOgVokmPmU+uhvdsc=
=BEcI
-----END PGP SIGNATURE-----

--=-1+JLqY5vS23ZiTAuZ6hD--

