Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314623AbSDTORX>; Sat, 20 Apr 2002 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314624AbSDTORW>; Sat, 20 Apr 2002 10:17:22 -0400
Received: from smtpsrv10.isis.unc.edu ([152.2.1.241]:65165 "EHLO smtp.unc.edu")
	by vger.kernel.org with ESMTP id <S314623AbSDTORV>;
	Sat, 20 Apr 2002 10:17:21 -0400
Date: Sat, 20 Apr 2002 10:16:56 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: update for {Re: [PATCHSET] Linux 2.4.19-pre7-jam1, -jam2}
Message-ID: <20020420141656.GA391@opeth.ath.cx>
In-Reply-To: <20020419232633.GA1775@werewolf.able.es> <Pine.LNX.4.10.10204200335390.19117-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2002 at 03:41:17AM -0700, Andre Hedrick wrote:
> http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.6.patch.bz2
>=20
> fixes hpt372
> migration towards modular chipsets
> devfs ide-scsi
> more but can not remember
> little uglyer but will collapse clean.
>=20
> thanks for testing...

Boots fine here. I'll bang on the ide-scsi bit by burning some stuff.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8wXhYMwVVFhIHlU4RApZuAJ408XsqbLVdIG9kThoyEqnOaYk81gCfd90L
R9ta7SR+/JiDAxuqOHGb2hU=
=4y6O
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
