Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUAWSeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266640AbUAWSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:34:08 -0500
Received: from mhub-c5.tc.umn.edu ([160.94.128.35]:701 "EHLO
	mhub-c5.tc.umn.edu") by vger.kernel.org with ESMTP id S266633AbUAWSeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:34:04 -0500
Subject: Re: gcc 2.95.3
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: Daniel Andersen <kernel-list@majorstua.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040123163008.B1237@beton.cybernet.src>
References: <20040123145048.B1082@beton.cybernet.src>
	 <20040123100035.73bee41f.jeremy@kerneltrap.org>
	 <20040123151340.B1130@beton.cybernet.src>
	 <001b01c3e1ca$26101f20$1e00000a@black>
	 <20040123163008.B1237@beton.cybernet.src>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oZT+CjTB4j2TfWdHJ1fj"
Message-Id: <1074882836.20723.4.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 12:33:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oZT+CjTB4j2TfWdHJ1fj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-23 at 10:30, Karel Kulhav=C3=BD wrote:
> On Fri, Jan 23, 2004 at 05:01:23PM +0100, Daniel Andersen wrote:
> > > I read here "make sure you have gcc 2.95.3 available" - does it mean
> > > my gcc-3.2.3 or gcc-3.2.2 is not suitable for kernel compiling?
> >=20
> > Please have a look at http://developer.osdl.org/cherry/compile/
>=20
> What if the kernel compiles cleanly but the generated code is invalid?
> Or is gcc-3.2.2 BugFree(TM) (BugFree as in BugFree speech, not as
> in BugFree beer)?

Many people have been using gcc-3.2 or later to build kernels, and I
haven't really heard of any problems with this, at least on i386. I
personally have used 3.2.2 and 3.3.2 (well, with Debian's patches) and
haven't had any weirdness with 2.6 or 2.4. ISTR there being arches that
need 3.x to compile, but I could be mistaken.

2.95.3 is definitely the *oldest* compiler you'd want to use, and pretty
much skip between that and 3.2.

Matt

--=-oZT+CjTB4j2TfWdHJ1fj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEWkTA9ZcCXfrOTMRAr3XAJ0aE/E36F8se5sVEf65gW8jCm62JwCfXjdf
KRgk3S+nVfv6GSD15eCdsHI=
=6N4q
-----END PGP SIGNATURE-----

--=-oZT+CjTB4j2TfWdHJ1fj--

