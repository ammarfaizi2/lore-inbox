Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265655AbUGITXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUGITXC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbUGITXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:23:02 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:38869 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S265655AbUGITW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:22:56 -0400
Date: Fri, 9 Jul 2004 21:22:53 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-ID: <20040709192253.GA11138@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
References: <20040709140630.GA27350@wavehammer.waldi.eu.org> <20040709120336.74e57ceb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20040709120336.74e57ceb.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 09, 2004 at 12:03:36PM -0700, Andrew Morton wrote:
> Bastian Blank <bastian@waldi.eu.org> wrote:
> >
> >  The attached patch marks IPv6 support for QETH broken, it is known to
> >  need an extra patch to compile which was submitted one year ago but
> >  never accepted.
>=20
> Well fixing it would be the preferable approach.  Where is the "extra
> patch" and what was the complaint?

The original submission is recorded on
http://marc.theaimsgroup.com/?l=3Dlinux-net&m=3D104551077013011&w=3D2. And =
the
complaint was that it puts '"ipv6 stuff" into the generic netdevice
structure'. I don't know if this can be solved another way.

Bastian

--=20
Earth -- mother of the most beautiful women in the universe.
		-- Apollo, "Who Mourns for Adonais?" stardate 3468.1

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkDu8I0ACgkQnw66O/MvCNG4xACdHajSv2AA1Gk+6QSN66dJk8fz
+nEAn2LlYW6QBL3HZgh4Sy0M7VFOsrT1
=REWr
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
