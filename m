Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289185AbSAVHh7>; Tue, 22 Jan 2002 02:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSAVHht>; Tue, 22 Jan 2002 02:37:49 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:55262 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S289185AbSAVHhn>; Tue, 22 Jan 2002 02:37:43 -0500
Date: Tue, 22 Jan 2002 02:37:42 -0500
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020122073742.GA767@opeth.ath.cx>
In-Reply-To: <20020122074806.A1547@athlon.random> <1011682739.17096.563.camel@phantasy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <1011682739.17096.563.camel@phantasy>
User-Agent: Mutt/1.3.26i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

No weird anomalies here. I believe the ones you refer to were a result
of ipv6 bits not being updated as well. Russell posted two patches for
those.

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101164602428323&w=3D2
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101164602428401&w=3D2

On Tue, Jan 22, 2002 at 01:58:58AM -0500, Robert Love wrote:
> > Only in 2.4.18pre4aa1/: 00_icmp-offset-1
> >=20
> > 	Remote security fix from Andi (see bugtraq).
>=20
> Are we sure this works?  I thought I saw someone (IRC perhaps?) who had
> weird anomalies with this fix (although it does certainly fix the hole).

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8TRbGMwVVFhIHlU4RAhnMAJ9gmHZANj0ZJSf8D6CuKEohpJOxWwCfU8Sl
479r2RAoIkirksZbfTRMkT8=
=gOxq
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
