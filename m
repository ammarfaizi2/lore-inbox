Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUE1GFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUE1GFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 02:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265822AbUE1GFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 02:05:45 -0400
Received: from mail.donpac.ru ([80.254.111.2]:38102 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265817AbUE1GFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 02:05:42 -0400
Date: Fri, 28 May 2004 10:05:40 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1
Message-ID: <20040528060540.GC7499@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040527015259.3525cbbc.akpm@osdl.org> <20040527115327.GA7499@pazke> <20040527112041.531a52e4.akpm@osdl.org> <20040528054653.GB7499@pazke> <20040527225231.722c3a93.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20040527225231.722c3a93.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 148, 05 27, 2004 at 10:52:31PM -0700, Andrew Morton wrote:
> Andrey Panin <pazke@donpac.ru> wrote:
> >
> > On 148, 05 27, 2004 at 11:20:41AM -0700, Andrew Morton wrote:
> > > Andrey Panin <pazke@donpac.ru> wrote:
> > > >
> > > > On 148, 05 27, 2004 at 01:52:59 -0700, Andrew Morton wrote:
> > > > >
> > > > > +make-proliant-8500-boot-with-26.patch
> > > > >=20
> > > > >  Fix hpaq proliant 8500
> > > >=20
> > > > Ugh, dmi_scan.c changed again ... :(
> > > >=20
> > >=20
> > > Confused.  What's the problem with that?
> >=20
> > Just yet another rediff of my DMI patches :)
>=20
> err, what DMI patches?
>=20
> > First patch attached
>=20
> -ENOCHANGELOG.

Sorry forgot about it. Patch changes DMI matching code, eliminating the nee=
d to
fill unused match entries with NO_MATCH macro.

> > , other will follow.
> > Can we apply them now ?
>=20
> Well they won't get applied if they're stuck on your hard disk.  Send 'em=
 over.

This is a third attempt already :)

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtta0by9O0+A2ZecRAiNeAJ91Oz6Kr6ViZWsm362hqiJuBzIEHQCgmWc8
l4F86G5DVo9kXHejjPk2N40=
=dO+s
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
