Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbTIMOhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 10:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTIMOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 10:37:43 -0400
Received: from nan-smtp-06.noos.net ([212.198.2.75]:25470 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S262157AbTIMOhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 10:37:37 -0400
Subject: RE: People, not GPL  [was: Re: Driver Model]
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEDKGIAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKIEDKGIAA.davids@webmaster.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jJh9OTtlORLknfib2G10"
Organization: Adresse personnelle
Message-Id: <1063463855.7962.50.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 13 Sep 2003 16:37:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jJh9OTtlORLknfib2G10
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le sam 13/09/2003 =E0 11:49, David Schwartz a =E9crit :

[...]

> > To avoid rewriting history symbols that could be used in non-free
> > stuff previously are not GPL-ONLY. People that ignore the hint can and
> > will be sued (people that link to symbols not GPL-ONLY could be sued to=
o
> > but everyone seems to have agreed to let it pass).
>=20
> 	Sued for what? Violating a restriction that isn't part of the license?
> That's no more illegal than removing the security checks on 'mount'.

Sued for not infringing the software license, in this case the GPL. They
won't be sued for removing GPL_ONLY checks ; they won't even be sued for
using GPL_ONLY symbols. They will be sued for distributing a non-GPLed
derived work when the license forbids it.

A symbol is marked GPL-only :
1. when there is no bloody way it could be used in another work without
it being a derived work
2. when the author of the associated kernel code publicly stated he will
go after you if you do not respect the license.

All the software "workarounds" proposed are only ways to infringe
without getting a big red warning in the face. They do not change the
reality of the infraction per see.

> > Removing the software
> > GPL-ONLY checks or working around them has nothing to do with it - it
> > does not change the basic kernel license nor the stated intentions of
> > its authors to enforce it. Hiding a do-not-trespass sign does not give
> > you the right to do it (if you think so do a reality check).
>=20
> 	Except that the GPL does not permit any usage restrictions.

There is no usage restriction - you have the code, you can remove the
checks if you want to. Unlike a license enforcement restriction you
won't be sued just for this.

Now the next step is usually to link a big fat closed module to your
modified kernel. And there you *will* be sued if you distribute the
resulting work (which pisses of some unethical corporations because the
sole way to do it legally is to have the end-user perform the operation,
and the end-user does not want to bother with it. ie its closes them
some markets unless they open up their stuff. Guess what ? You won't
find any people on this list cry for them).

I even suspect if you submit a patch to have GPL-ONLY a kernel build
option it will be accepted (provided it taints the whole kernel
probably). Distributions of course will never ship binaries build
without it, and appliance manufacturers that use it will be submitted to
heavy review, but that's already the case.

--=20
Nicolas Mailhot

--=-jJh9OTtlORLknfib2G10
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/YyuvI2bVKDsp8g0RApzWAKDqQlHA19F8O9qIuCTy5ytuZS7vwACguZjR
WcmALhiHfdf7JO+w17s+IxU=
=2ZFi
-----END PGP SIGNATURE-----

--=-jJh9OTtlORLknfib2G10--

