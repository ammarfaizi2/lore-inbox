Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314652AbSEYPJP>; Sat, 25 May 2002 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314659AbSEYPJO>; Sat, 25 May 2002 11:09:14 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:46015 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314652AbSEYPJN>; Sat, 25 May 2002 11:09:13 -0400
Subject: Re: RTAI/RtLinux
From: Erwin Rol <erwin@muffin.org>
To: Der Herr Hofrat <der.herr@mail.hofr.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        RTAI users <rtai@rtai.org>
In-Reply-To: <200205251321.g4PDLLU16552@hofr.at>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-MBkXqA6YMGyd4N/Rt6Sa"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 May 2002 17:08:42 +0200
Message-Id: <1022339322.29849.286.camel@rawpower>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MBkXqA6YMGyd4N/Rt6Sa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-05-25 at 15:21, Der Herr Hofrat wrote:
> >=20
> > > LGPL can be used as GPL. If you haven't even read the license do that
> > > before the flamewar please.
> > >=20
> >=20
> > I know this, the point is that when you use the LGPL to be used as the
> > GPL it is not really LGPL anymore. A binary program using GLIBC depends
> > on the fact that GLIBC allows that (because of its LGPL license). What =
i
> > wanted to say is that "allowance" might be taken away by the patent
> > license.
>=20
> The basic problem is again that some people want to have the privileges o=
f=20
> GPL without the responsibilities of GPL. That is a very old debate and I
> don't think it is sensible to krank it through again. Do GPL work and
> you can use the services of the comunity, do non-GPL and you need to=20
> get these services under other terms. I realy don't see whats so wrong
> unfair and evil about this.

The "serice" in this cause is not sourcecode, or an other product, it is
an idea. I totally agree with you that when you want to derive from GPL
software you should comply with its license. This is not about deriving
software, this is about the use of an idea, which happens to be made
into a patent (by a patent office with a very questionable reputation,
also in this case as lots of ppl pointed out before).

>=20
> > It is like a patent on VM management, or some other kernel internal
> > technique, does that mean that that patent is also has something to say
> > about ppl that write programs for that OS ? The same with LXRT (the
> > userspace part of RTAI), its implementation might fall under the patent=
,
> > but does the program that uses the LXRT services also fall under the
> > patent ?=20
>=20
> The question of derived work is realy exhaustively discused and there are
> plenty of statements on this including statements by the FSF itselfe.
> mere agregation of work does not put you under any copywrite restrictions=
,
> derived work does - drawing this line is not easy and expecting anybody t=
o
> give you "the definitive guide on derived work" is a bit naiv.
> You might want to scan the FSF statements on these issues...

Those statements are mostly valid for copyright cases, where i derive a
piece of software from a other piece of software. These are very hard to
map to patent cases like this one is. Cause if this was about deriving
software, RTAI developers would have no problem with FSMLabs at all,
cause we write our own software or we comply to the license of the
software we use (keep in mind that RTAI was LGPL, and is now GPL, so
RTAI itself is in no way colliding with the GPL). It is about users of
RTAI that might want to keep their program non-GPL, and the question is,
are they allowed to. Since they are not deriving from RTAI (they just
use the services it offers) they are free to do so, when it would be a
simple copyright case, but FSMLabs thinks different on this point. So
thats what this is all about, where does the patent "stop" ? that
question was always pushed into the copyright corner, and never answered
correctly, apart by Eben Moglen, who apparently is not qualified enough
to say anything on this topic (when i have to believe some ppl).=20

- Erwin


>=20
> hofrat


--=-MBkXqA6YMGyd4N/Rt6Sa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA876j6ILu3T9PlUj8RAsJcAJ9lEuWGLtCzgah+SAwPefs/m7tOvwCffmhJ
u1aEt1+EL2NxIgSCMpvQOn8=
=0//3
-----END PGP SIGNATURE-----

--=-MBkXqA6YMGyd4N/Rt6Sa--
