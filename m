Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRAZUFU>; Fri, 26 Jan 2001 15:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRAZUFL>; Fri, 26 Jan 2001 15:05:11 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14329 "EHLO
	morcego.distro.conectiva") by vger.kernel.org with ESMTP
	id <S129397AbRAZUE4>; Fri, 26 Jan 2001 15:04:56 -0500
Date: Fri, 26 Jan 2001 18:05:54 -0200
From: "Rodrigo Barbosa (aka morcego)" <rodrigob@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
Message-ID: <20010126180554.I19067@conectiva.com.br>
In-Reply-To: <20010126141350.Q6979@capsi.com> <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com> <20010126131949.A1041@bessie.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126131949.A1041@bessie.dyndns.org>; from jlnance@intrex.net on Fri, Jan 26, 2001 at 01:19:49PM -0500
X-GeekCode-Version: 3.1
X-GeekCode: CS/IT$ d- s+: a-->- C++++(++) UL++++ P--- L+++(++++)$ E--- W+(++) N+(++) o K? w--- O- M- V PS+ PE++ Y+(++) PGP++(+++) t+>++ 5+(++) X+ R++(*) tv+ b+++ DI++++ D+ G++ e h* r++ y+++
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2001 at 01:19:49PM -0500, James Lewis Nance wrote:
> On Fri, Jan 26, 2001 at 08:49:31AM -0500, Richard B. Johnson wrote:
>=20
> > On Fri, 26 Jan 2001, Rob Kaper wrote:
> > > Is there a way to rename lost+found ?? It bothers me to see it in ls =
all the
>=20
> > Get used to it. This is part of the Linux/Unix heritage!  A file-system
> > without a lost+found directory is like love without sex.
>=20
> FWIW IBM's JFS file system does not have a lost+found directory.  I dont
> remember if reiserfs does or not.

I think JFS indeed doesn't have it. And ReiserFS doesn't too. This=20
should be common place for journaling filesystems.

[]s

--=20
 Rodrigo Barbosa (morcego)         - rodrigob at conectiva.com.br
 Conectiva R&D Team                - http://distro.conectiva.com.br
 "Quis custodiet ipsos custodiet?" - http://www.conectiva.com


--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6cdiin5NdOMMM/nERAoIUAJ92sQKbaIrWiUYmfjHDwBcyBD29UACfaxhC
BjZSMYEa4vdjwmcSJbpf0wE=
=3h+/
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
