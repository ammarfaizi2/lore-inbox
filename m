Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSL3Uby>; Mon, 30 Dec 2002 15:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSL3Uby>; Mon, 30 Dec 2002 15:31:54 -0500
Received: from ulima.unil.ch ([130.223.144.143]:34213 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S265843AbSL3Ubx>;
	Mon, 30 Dec 2002 15:31:53 -0500
Date: Mon, 30 Dec 2002 21:40:17 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools-0.9.7 on MDK 9.0
Message-ID: <20021230204017.GA8809@ulima.unil.ch>
References: <1041280171.11695.51.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1041280171.11695.51.camel@garaged.fis.unam.mx>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2002 at 02:29:31PM -0600, Max Valdez wrote:
> Hi all:
>=20
> Again, in the process of compiling and installing kernel 2.5.53, I got
> the tip of module-init-tools-0.9.7 needed (from Frank Davis, Thanks!),
> but when i try to install it, I get this error:
>=20
> gcc  -g -O2  -o insmod.static -static insmod.o
> /usr/bin/ld: cannot find -lc
> collect2: ld returned 1 exit status
> make: *** [insmod.static] Error 1

Just install glibc-static-devel...

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+EK8qFDWhsRXSKa0RAg18AJ0V0yMmrghEsr4MOSNtZ9unRsYjtQCdHr9x
Op8h03dZ8iwt682JmA/TEdM=
=/F+n
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
