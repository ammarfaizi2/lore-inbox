Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSGXWkl>; Wed, 24 Jul 2002 18:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSGXWkl>; Wed, 24 Jul 2002 18:40:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8204 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317616AbSGXWkd>; Wed, 24 Jul 2002 18:40:33 -0400
Date: Wed, 24 Jul 2002 23:43:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
Message-ID: <20020724234344.I25115@flint.arm.linux.org.uk>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 24, 2002 at 02:13:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2002 at 02:13:49PM -0700, Linus Torvalds wrote:
> Russell King <rmk@arm.linux.org.uk>:
>   o Serial driver stuff

I'd just like to clear up some confusion here.

Under this cset is a change that adds '-g' to the top-level make flags.
This cset, although it has my name and comments against it is actually
a patch that added the serial drivers and extra bits that Ingo sent to
Linus (and Linus kindly credited it back to me, and took the comments
from one of my patch submissions for the serial drivers.)

The addition of '-g' is not, and has never been in my serial patches;
please do not direct comments about the '-g' to me.  Any problems
relating to the serial changes should be forwarded to me.

Thanks.

--=20
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Lin=
ux
             http://www.arm.linux.org.uk/personal/aboutme.html


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Py2gMsXkn0JWU2IRArWJAKCD0gm6ZbxH5eqSTmHS5ssgLMusUQCeIAMo
geHfXu/rtExG9GO7TaU5fLw=
=/7Iu
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
