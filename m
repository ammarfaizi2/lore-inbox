Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVAMP0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVAMP0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVAMP0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:26:14 -0500
Received: from zero.voxel.net ([209.123.232.253]:47286 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S261646AbVAMP0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:26:08 -0500
Subject: Re: 2.6.10-as1
From: Andres Salomon <dilinger@voxel.net>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41E648D4.1050906@bio.ifi.lmu.de>
References: <1105605448.7316.13.camel@localhost>
	 <41E648D4.1050906@bio.ifi.lmu.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sPnXIyTP6x71+bFcrTbc"
Date: Thu, 13 Jan 2005 10:26:00 -0500
Message-Id: <1105629960.9553.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sPnXIyTP6x71+bFcrTbc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-13 at 11:09 +0100, Frank Steiner wrote:
> Andres Salomon wrote
>=20
> > Hi,
> >=20
> > I'm announcing a new kernel tree; -as.  The goal of this tree is to for=
m
> > a stable base for vendors/distributors to use for their kernels.  In
> > order to do this, I intend to include only security fixes and obvious
> > bugfixes, from various sources.  I do not intend to include driver
> > updates, large subsystem fixes, cleanups, and so on.  Basically, this i=
s
> > what I'd want 2.6.10.1 to contain.
>=20
> Very nice idea! Not only for distributors! Thanks for doing this!
> Do you plan to maintain -as only for the latest release, i.e., will
> 2.6.10-as still be maintained with security fixes even when 2.6.11-as
> comes up?
>=20

My plan is to include security fixes for a kernel or two behind what is
the latest.  Currently, I'm supporting (for Debian) 2.6.8 through
2.6.10.  Of course, normally I wouldn't support 2.6.8 for this long, but
since sarge will (hopefully?) be releasing someday, and this is the
kernel chosen for it, I must continue support.

I do not plan to continue small bugfixes for older kernels too much
longer after a new kernel is released; however, if people were to feed
me patches for older kernels, I'd be more than happy to do releases.


--=20
Andres Salomon <dilinger@voxel.net>

--=-sPnXIyTP6x71+bFcrTbc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB5pMH78o9R9NraMQRAiDfAKDK4He56FzexUFTZlmB1PpOMPzl1ACgtHWT
PmxOhdEV6LHa8CvLKzTEx1E=
=OoQY
-----END PGP SIGNATURE-----

--=-sPnXIyTP6x71+bFcrTbc--

