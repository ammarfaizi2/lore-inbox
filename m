Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264996AbUEYRxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264996AbUEYRxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUEYRxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:53:30 -0400
Received: from wblv-36-95.telkomadsl.co.za ([165.165.36.95]:13977 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264996AbUEYRwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:52:55 -0400
Subject: Re: Distributions vs kernel development
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Rene Rebe <rene@rocklinux-consulting.de>
Cc: kangur@polcom.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       rock-user@rocklinux.org
In-Reply-To: <20040525.102241.635758403.rene@rocklinux-consulting.de>
References: <Pine.LNX.4.58.0405091057060.14709@alpha.polcom.net>
	 <20040509.111350.67880957.rene@rocklinux-consulting.de>
	 <1085426241.9516.7.camel@nosferatu.lan>
	 <20040525.102241.635758403.rene@rocklinux-consulting.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0hNMEcwG6YCvYOfaQ+zO"
Message-Id: <1085507592.9516.14.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 May 2004 19:53:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0hNMEcwG6YCvYOfaQ+zO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-25 at 10:22, Rene Rebe wrote:
> Hi,
>=20
> On: Mon, 24 May 2004 21:17:21 +0200,
>     Martin Schlemmer <azarah@nosferatu.za.org> wrote:
> > On Sun, 2004-05-09 at 11:13, Rene Rebe wrote:
> >=20
> > > But the last time I took a look not even an installer or such. +
> > > Gentoo has no support for custom modifications not even thinking abou=
t
> > > a way to group such custom modifications / build configuration into a
> > > well defined way to form a distribution. + ROCK Linux has a real
> > > sandbox build environment, not this optimization via CFLAGS, and so o=
n
> > > Gentoo wannabe.
> > >=20
> >=20
> > Weird .. last time I checked, Gentoo sandbox was originally derived fro=
m
> > ROCK Linux's sandbox wrapper ....
>=20
> Interesting ,) I did not know Gentoo copied ROCK Linux code, too.

Yeah, well, started out that way, as G. Bevin who wrote it at the
time, came from ROCK Linux (user I think).  I do not think it resembles
it much, if at all anymore though, and I know some additions have
been added that you guys might think about, like also hooking execve
(meaning subsequent bash's will still have LD_PRELOAD=3Dsandboxlib
 in env, and if make/whatever sets LD_PRELOAD, the wrapper will add
 the sandboxlib back, etc), and one or two others I think.


Regards,

--=20
Martin Schlemmer

--=-0hNMEcwG6YCvYOfaQ+zO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAs4gIqburzKaJYLYRAsREAJ9j0/P5nt6sz8pm1F86uURjKtyxiQCbBsvF
hNm80qgCS54DjvJIn09mBxo=
=7RQa
-----END PGP SIGNATURE-----

--=-0hNMEcwG6YCvYOfaQ+zO--

