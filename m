Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTESUWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTESUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:22:52 -0400
Received: from cpt-dial-196-30-180-143.mweb.co.za ([196.30.180.143]:63360 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262776AbTESUWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:22:15 -0400
Subject: RE: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       David Ford <david+cert@blue-labs.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D3AA@mcoexc04.mlm.maxtor.com>
References: <785F348679A4D5119A0C009027DE33C102E0D3AA@mcoexc04.mlm.maxtor.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pCIpbQM0/bdMfYRZIT9N"
Organization: 
Message-Id: <1053376587.7862.72.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 19 May 2003 22:36:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pCIpbQM0/bdMfYRZIT9N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-19 at 21:54, Mudama, Eric wrote:
> On Monday, May 19, 2003 1:44 PM, Martin Schlemmer wrote:
> > I think on the one hand the question is also ... how far
> > will a developer of one distro go to help another.  I
> > cannot say that I have had much success in the past to
> > get a response from one of the 'big guys' to help me/us
> > (the 'small guys') =3D)
>=20
> AFAIK, it doesn't matter if a distro helps another or not.  As per Arjan =
van
> de Ven's comment, I would think any code they release in terms of header
> files based on original GPL source is itself GPL, and therefore
> includable/usable/modifyable/redistributable by any distro.
>=20
> Red Hat (or insert other large distro vendor here) might not want to
> explicitly "help" their little competitors, but they have appeared to sol=
ve
> this problem (according to other posts) and there's no reason you can't b=
ase
> your own work off of that...
>=20

Was actually more referring to accepting patches to fix issues, or even
just replying in general on the patch.


--=20

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa



--=-pCIpbQM0/bdMfYRZIT9N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+yUBLqburzKaJYLYRAvt/AJ0TXyif/U0B4D0mUiFROeuDPYR3lACfWUIt
BDYnJSxITp3TcL0lqjfW1a8=
=EI8n
-----END PGP SIGNATURE-----

--=-pCIpbQM0/bdMfYRZIT9N--

