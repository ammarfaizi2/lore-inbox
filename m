Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270473AbTHCMvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 08:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHCMvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 08:51:13 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:47773 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S270473AbTHCMvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 08:51:07 -0400
Subject: Re: [2.6] Perl weirdness with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: From@mail1.tamperd.net, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <m365lfgpob.fsf@bzzz.home.net>
References: <1059856625.14962.19.camel@nosferatu.lan>
	 <m365lfgpob.fsf@bzzz.home.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kxvjMuhr/G6ORbuuuiqa"
Message-Id: <1059915061.8312.11.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 14:51:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kxvjMuhr/G6ORbuuuiqa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-08-03 at 09:34, Alex Tomas wrote:
> could you send full strace for this?
>=20

Complete strace can be found here:

  http://dev.gentoo.org/~azarah/trace.log.bz2

> >>>>> Martin Schlemmer (MS) writes:
>=20
>  MS> Hi
>  MS> I have mailed about this previously, but back then it was not
>  MS> really confirmed, so I have let it be at that.
>=20
>  MS> Anyhow, problem is that for some reason 2.5/2.6 ext3 with HTREE
>  MS> support do not like what perl-5.8.0 does during installation.
>  MS> It *seems* like one of the temporary files created during manpage
>  MS> installation do not get unlinked properly, or gets into the
>  MS> hash (this possible?) and cause issues.
>=20
>  MS> It seems to work flawless on 2.4 still.
>=20
>  MS> Also, to be honest, I do not have that much free time these days,
>  MS> so if an interest in helping me/us debug this, it will be appreciate=
d
>  MS> if some direction in what is needed/suggestions can be given as to w=
hat
>  MS> is required.  There are a few users that experience this issue, and
>  MS> I am sure that we can get whatever info needed.
>=20
>  MS> A bug on our tracker is here with more (hopefully) complete info:
>=20
>  MS>   http://bugs.gentoo.org/show_bug.cgi?id=3D24991
>=20
>=20
>  MS> Thanks,
>=20
>  MS> --=20
>=20
>  MS> Martin Schlemmer
>=20
>=20
--=20

Martin Schlemmer




--=-kxvjMuhr/G6ORbuuuiqa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/LQU1qburzKaJYLYRAhu4AJ9zJOlduvJeFSQGshtxt5Wk3K/9lgCfWctU
XtCVG+MnIbLrsii+zhQenr8=
=GT/q
-----END PGP SIGNATURE-----

--=-kxvjMuhr/G6ORbuuuiqa--

