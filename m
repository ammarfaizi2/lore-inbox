Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290878AbSARXku>; Fri, 18 Jan 2002 18:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290879AbSARXkb>; Fri, 18 Jan 2002 18:40:31 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:42173 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S290878AbSARXkU>; Fri, 18 Jan 2002 18:40:20 -0500
Date: Fri, 18 Jan 2002 18:40:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.16
Message-ID: <20020118234015.GA3694@opeth.ath.cx>
In-Reply-To: <3C3E7F89.AB2F629@zip.com.au> <1011395469.850.8.camel@phantasy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <1011395469.850.8.camel@phantasy>
User-Agent: Mutt/1.3.25i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar experience here. Has withstood abuse on my UP and SMP machines
(a variety of 2.4.17 and 2.4.18-pre4). Thanks!

On Fri, Jan 18, 2002 at 06:10:29PM -0500, Robert Love wrote:
> On Fri, 2002-01-11 at 01:00, Andrew Morton wrote:
> > A small ext3 update.  It fixes a few hard-to-hit but potentially
> > serious problems.  The patch is against 2.4.18-pre3, and is also
> > applicable to 2.4.17.
>=20
> I didn't see any feedback so I wanted to confirm success on my
> 2.4.18-pre4 UP machine.  Survived prolonged use and some initial
> stressing.  Good job.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8SLJfMwVVFhIHlU4RAvzfAJ0RA4+8gR47n5q/Zr6HrnIy/o52ZgCfcrrN
xzc93KJuUVuZEmfVmN/gh8w=
=zKGQ
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
