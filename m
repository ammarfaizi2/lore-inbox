Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbTCWVJ1>; Sun, 23 Mar 2003 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263242AbTCWVJ1>; Sun, 23 Mar 2003 16:09:27 -0500
Received: from mh57-mps.martin.mh57.de ([213.68.114.153]:10448 "EHLO
	mh57-mps.martin.mh57.de") by vger.kernel.org with ESMTP
	id <S263238AbTCWVJZ>; Sun, 23 Mar 2003 16:09:25 -0500
Date: Sun, 23 Mar 2003 22:20:30 +0100
From: Martin Hermanowski <martin@mh57.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323212030.GD2645@mh57.de>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.3i
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2003 at 09:36:28PM +0100, Pavel Machek wrote:
> Hi!
>=20
> > > Do not get me wrong, I think users can and should compile their own
> > > kernel if they want.  And as kernel developers, we should facilitate
> > > that.  But if someone requires handholding and instant or controlled
> > > releases of bug fixes, they either need to be able to rely on their o=
wn
> > > ability to get them or their vendor.  We have vendors for a reason,
> > > after all.
> >=20
> > If that's people's attitude ("you should use a vendor"), then we
> > need a=20
>=20
> I believe sentence "you should use a vendor kernel" schould be banned
> on this list ;-).

ACK ;-)

> How badly would releasing 2.4.21 which does not have 2.4.20-preX as a
> parent mess version control systems? =20

I guess this would make problems with the incremental patches.

I think putting an official patch for 2.4.20 closing the ptrace hole on
www.kernel.org should be no problem, and people compiling the kernel
themselves could easily use a correctly patched kernel. The main problem
(IMHO) is finding the correct patch. Even a link to the mail in the
archive might be sufficient.

(I hope this has not been suggested before, I was unsubsribed to lkml
for some days)

Regards,
Martin

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+fiUdV3BRtc7IW1wRAtgwAJ0XpRLlVOAqEqiWNLSAs/FrdvoDJwCfUZ+k
lk3KjYqgWJT+U3pxT0PB63A=
=f2Ga
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
