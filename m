Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSFBWRM>; Sun, 2 Jun 2002 18:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFBWRL>; Sun, 2 Jun 2002 18:17:11 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:57337 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S316886AbSFBWRI>;
	Sun, 2 Jun 2002 18:17:08 -0400
Date: Mon, 3 Jun 2002 00:16:46 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: SMB filesystem
Message-ID: <20020602221646.GF14126@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3CFA875D.1050300@linkvest.com> <Pine.LNX.4.44.0206022319290.27283-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2002 at 11:34:59PM +0200, Urban Widmark wrote:
> Currently autofs has a problem where it won't show the mountpoints of
> non-mounted directories, but I think you would run into that problem too.
> (short version of the problem: how do you prevent 'ls -l' from mounting
>  all filesystems in a directory?)

It would be nice to have this fixed, that is, to allow listing of
potential mountpoints, and ignore stat() on them instead of trying to
mount immediately.

BTW that's the only remaining feature that makes supermount more
"user-friendly" than autofs for floppies/CD-ROMs.

Marius Gedminas
--=20
=2E.. there is always a well-known solution to every human problem -- neat,
plausible, and wrong.
		-- H. L. Mencken (1880-1956), "Prejudices"

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8+plOkVdEXeem148RAuq8AJ4r/5vdNfpYHSaTxKN2dX+o0AO8UgCeMVi/
iyXPeGWSFNHT0jqpnzzcPEI=
=LQdR
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
