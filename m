Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265737AbUFILnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbUFILnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 07:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUFILnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 07:43:55 -0400
Received: from [213.69.232.58] ([213.69.232.58]:20747 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S265737AbUFILnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 07:43:40 -0400
Date: Wed, 9 Jun 2004 13:46:15 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: GCS <gcs@lsc.hu>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       Chris Wright <chrisw@osdl.org>, Amon Ott <ao@rsbac.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dev@grsecurity.net
Subject: Re: security patches / lsm
Message-ID: <20040609114615.GK601@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	GCS <gcs@lsc.hu>, Chris Wright <chrisw@osdl.org>,
	Amon Ott <ao@rsbac.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dev@grsecurity.net
References: <20040122191158.GA1207@schottelius.org> <20040122150937.A8720@osdlab.pdx.osdl.net> <20040609090346.GG601@schottelius.org> <20040609112235.GA1088@pooh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline
In-Reply-To: <20040609112235.GA1088@pooh>
X-MSMail-Priority: (u_int) -1
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

GCS [Wed, Jun 09, 2004 at 01:22:35PM +0200]:
> * Nico Schottelius <nico-kernel@schottelius.org> [2004-06-09 11:03:46 +02=
00]:
>=20
> > Who decides whether to integrate them or not?
>  Linus? AFAIK he already said no to grsecurity.

I heard about that, but I wanted to know whether this statement is still
true. I think with grsecurity you get a great security enhanced kernel.

And if the performance is really getting worse, why not add grsecurity
patches with #ifdef GRSECURITY_ENABLED?=20

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nerd-hosting.net | http://nico.schotteli.us

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQMb4hbOTBMvCUbrlAQIOJRAAhWUaWLXdmpkaz/ZuRc3sDGWlLS//3sQo
2z3T8mkMxyzR28v0g49Cjwqdpy3w2e5rr7dcaO6lCjEHBG894i4Gs37wQodAm9tT
A2+sQwTM45/cqMwkAsvVFhxhpz8/TPZfw4whZYCtvUAD90Zx7JsTrlUR192yn6we
QjQP1uoSmkh8NtCwYWJ5xynUCF4K2KzO+msu+IlSiAspPxQuIOSmxm5SfX5mQrIG
RpCOR2DQ7n1IeafZbicfMIaSOps4lxcd50gwoQvlWGCcXnZGQGAtBpuXZAs0h6x5
XVyRgNUYpei5btw0KOYEry5Xab7IidzPBMSMnvHAKni0nzD+96f8y24MIDQDa601
m1GtRpwQCRCnw53aAXTQhUzE0Tx3k/p1w2224rWataC9/kpgl0gtCZvSiBCQsAaI
AQ18nP2GVUCTrv/F8eCFz9f5/UzFUBEpkJbZ1qC8kS4tCbWlGFwOxpNJel7dPJgg
QvB+XUlE9xKcur31tZLa7peCC13TizT9O+WGJrDbzlvQh+LMWg7SWKuQeNbsYCAa
OEN/F+KgIuXDfSnEcyqAC1bnMAcY2gIOUenj+WfEKJKpsFVUMiuE359SMxahiIT3
IsKJSRL+zAK/HFI03y6bFq8N+KkhHJzbhfh3EJztJqmjRijT1ptrZblgNwn9/kdl
e4FInRhGIOA=
=X2hr
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--
