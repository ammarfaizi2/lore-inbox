Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263018AbTCWLBN>; Sun, 23 Mar 2003 06:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263019AbTCWLBN>; Sun, 23 Mar 2003 06:01:13 -0500
Received: from NeverAgain.DE ([217.69.76.1]:14031 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id <S263018AbTCWLBL>;
	Sun, 23 Mar 2003 06:01:11 -0500
Date: Sun, 23 Mar 2003 12:11:46 +0100
From: Martin Loschwitz <madkiss@madkiss.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030323111146.GA1558@minerva.local.lan>
References: <20030322103121.A16994@flint.arm.linux.org.uk> <1048345130.8912.9.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.51L0.0303231225070.15290@lapd.cj.edu.ro> <20030323103854.A16548@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20030323103854.A16548@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2003 at 10:38:54AM +0000, Russell King wrote:
>=20
> Today, security is based around the capability system, not UID numbers.
>=20
So can you send a patch to make this work the right[tm] way? I need this
capability as well...

> --=20
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM L=
inux
>              http://www.arm.linux.org.uk/personal/aboutme.html
>=20

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+fZZyHPo+jNcUXjARAmD+AJ4kXoSERnk5SAkNyKeL+HBi1VA9sACfX/JW
89upszve472pwM85uwxZqMk=
=E4uk
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
