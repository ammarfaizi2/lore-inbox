Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVL1O53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVL1O53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVL1O53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:57:29 -0500
Received: from mail.gmx.net ([213.165.64.21]:36563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964833AbVL1O53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:57:29 -0500
X-Authenticated: #5339386
Date: Wed, 28 Dec 2005 15:55:03 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc6
Message-ID: <20051228145502.GB9777@sidney>
References: <20051228135021.GA9777@sidney> <43B2A122.7030203@thinrope.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <43B2A122.7030203@thinrope.net>
User-Agent: Mutt/1.5.11
From: Mathias Klein <ma_klein@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2005 at 11:28:50PM +0900, Kalin KOZHUHAROV wrote:
> Mathias Klein wrote:
> > Hello all,
> >=20
> > [please CC me on replies, I'm not subscribed to this list]
> >=20
> > I had this following kernel oops while compiling a new kernel.=20
> >=20
> > Dec 27 19:02:00 sidney kernel: [14896.995613] Unable to handle kernel p=
aging request at virtual address 76f7104d
> > Dec 27 19:02:00 sidney kernel: [14896.995665]  printing eip:
> > Dec 27 19:02:00 sidney kernel: [14896.995682] c013a392
> > Dec 27 19:02:00 sidney kernel: [14896.995692] *pde =3D 00000000
> > Dec 27 19:02:00 sidney kernel: [14896.995711] Oops: 0002 [#1]
>=20
> I might be wrong, but that is the second oops for this run, probably the =
first [#0] is more
> interesting...

Probably yes but there is no [#0] Oops in the logs.
(Indeed I do have another [#1] Oops in another run with that kernel without
an [#0] Oops)

Mathias

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDsqdGPtJqRGqEpd8RAn3eAKCVx3W7Y3YHE4nAMlRxwb3a5UYhxQCgxupu
zunwQfT6nEy+GHEtEYUrkYg=
=Q+/E
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
