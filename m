Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSAVSqu>; Tue, 22 Jan 2002 13:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSAVSqk>; Tue, 22 Jan 2002 13:46:40 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:33454 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S289341AbSAVSqe>; Tue, 22 Jan 2002 13:46:34 -0500
Date: Tue, 22 Jan 2002 13:46:26 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre5
Message-ID: <20020122184626.GC1562@opeth.ath.cx>
In-Reply-To: <Pine.LNX.4.21.0201221514140.2056-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201221514140.2056-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.26i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Eh, it is just me or are patch-2.4.18-pre5.{bz2,gz} borked?

Patching on top of pristine 2.4.17 gives me more than a few rejects.
=46rom ftp.kernel.org:

3c2fdf92d961145c100a99c6e3225f48  patch-2.4.18-pre5.bz2

On Tue, Jan 22, 2002 at 03:20:24PM -0200, Marcelo Tosatti wrote:
>=20
> Hi,=20
>=20
> I was waiting for the icmp overflow problem to be fixed to release this
> kernel, but it only exists only on 2.2.
>=20
> Well, here goes pre5.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8TbOCMwVVFhIHlU4RAq1iAJ0YVSt/gjd7cjg5vFaKWvsVDU3lcACfXdzX
vH7Mi/FBXsUMCSCtb003DNw=
=uCJG
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
