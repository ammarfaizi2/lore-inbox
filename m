Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVAMTOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVAMTOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVAMTL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:11:59 -0500
Received: from zero.voxel.net ([209.123.232.253]:52442 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S261362AbVAMTIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:08:52 -0500
Subject: Re: 2.6.10-as1
From: Andres Salomon <dilinger@voxel.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41E6D5F8.2040901@gentoo.org>
References: <1105605448.7316.13.camel@localhost>
	 <41E6D5F8.2040901@gentoo.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tK1WkF6cZrE3N7vjqdsX"
Date: Thu, 13 Jan 2005 14:08:39 -0500
Message-Id: <1105643319.5148.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tK1WkF6cZrE3N7vjqdsX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-13 at 20:11 +0000, Daniel Drake wrote:
> Hi,
>=20
> Andres Salomon wrote:
> > I'm announcing a new kernel tree; -as.  The goal of this tree is to for=
m
> > a stable base for vendors/distributors to use for their kernels.  In
> > order to do this, I intend to include only security fixes and obvious
> > bugfixes, from various sources.  I do not intend to include driver
> > updates, large subsystem fixes, cleanups, and so on.  Basically, this i=
s
> > what I'd want 2.6.10.1 to contain.
>=20
> After all of the recent discussion it's nice to see someone step up and d=
o this :)
> Thanks a lot, I'm sure I will find it useful when producing gentoo's kern=
el=20
> packages..
>=20
> Just one suggestion- maybe could you distinguish security patches from=20
> bugfixes? I.e. prepend or append the security patches with "sec" or somet=
hing?
>=20

I could certainly do that.  Right now, I mark them w/ [SECURITY] in the
changelog.


--=20
Andres Salomon <dilinger@voxel.net>

--=-tK1WkF6cZrE3N7vjqdsX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB5sc378o9R9NraMQRAlLhAKCTDxlOQVmQ57Qyftbj46vAOAfExgCgmLwi
vaO2L09DU33nVchUJUDpsEg=
=MKk8
-----END PGP SIGNATURE-----

--=-tK1WkF6cZrE3N7vjqdsX--

