Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288992AbSANUfN>; Mon, 14 Jan 2002 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSANUc1>; Mon, 14 Jan 2002 15:32:27 -0500
Received: from UX3.SP.CS.CMU.EDU ([128.2.198.103]:12391 "HELO
	ux3.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S289013AbSANUbT>;
	Mon, 14 Jan 2002 15:31:19 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
	the elegant solution)
From: Justin Carlson <justincarlson@cmu.edu>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020114145035.E17522@thyrsus.com>
In-Reply-To: <20020114132618.G14747@thyrsus.com>
	<m16QCNJ-000OVeC@amadeus.home.nl>  <20020114145035.E17522@thyrsus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DPX0qPgcxV5HQj95+lQ1"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Jan 2002 15:30:46 -0500
Message-Id: <1011040246.19071.42.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DPX0qPgcxV5HQj95+lQ1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

There are many times I would have found (and, I anticipate, many times I
will find) an autoconfigurator useful in my work, if only to get a
rough-cut kernel configuration done in minimal time.  For my purposes,
it doesn't have to be 100% correct to save me some significant amount of
work.

Does this mean I'm incapable of configuring a kernel with the available
tools?  No.  And it doesn't mean I think there needs to be some grand
shift in the way distro vendors provide kernels, but this kind of a
facility would be useful for *me*.  I don't want to get into whether
this is an appropriate thing to make easily accessible to good ol' Aunt
Tillie.=20

>From the other side, how does having the ability to probe local hardware
hurt?  It should be cleanly seperable from the classical build process
for the purists, and helpful to some (I think) significant portion of
the userbase, particularly those folks who like to test bleeding edge
stuff on a variety of hardware.  I don't really understand the
resistance to the idea of someone going out and implementing this.

my $.02.

-Justin

--=-DPX0qPgcxV5HQj95+lQ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Qz/247Lg4cGgb74RAqpcAKDE+NVnfV19AkQOcCAff8fei04qAQCgk4re
TYUz+vTp9nAAYiQv0JiABfU=
=6C03
-----END PGP SIGNATURE-----

--=-DPX0qPgcxV5HQj95+lQ1--

