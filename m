Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTEJJ4W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTEJJ4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:56:22 -0400
Received: from adsl-67-124-157-215.dsl.pltn13.pacbell.net ([67.124.157.215]:992
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263738AbTEJJ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:56:21 -0400
From: Joshua Kwan <joshk@triplehelix.org>
Date: Sat, 10 May 2003 03:08:08 -0700
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: OOPS in smbfs module - 2.5.69-mm1
Message-ID: <20030510100808.GA732@triplehelix.org>
References: <20030510053548.GA23841@triplehelix.org> <Pine.LNX.4.50.0305100440150.11047-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305100440150.11047-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2003 at 05:24:13AM -0400, Zwane Mwaikambo wrote:
> You appear to be in a very bad place, looks like list corruption, possibl=
y=20
> a prefetch into never never land, which gcc version are you using? Can yo=
u=20
> reproduce easily?

joshk@firesong:~> gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
Configured with: ../src/configure -v
--enable-languages=3Dc,c++,java,f77,objc,ada --prefix=3D/usr
--mandir=3D/usr/share/man --infodir=3D/usr/share/info
--with-gxx-include-dir=3D/usr/include/c++/3.2 --enable-shared
--with-system-zlib --enable-nls --without-included-gettext
--enable-__cxa_atexit --enable-clocale=3Dgnu --enable-java-gc=3Dboehm
--enable-objc-gc i386-linux
Thread model: posix
gcc version 3.2.3

I'm unable to reproduce it now. If I do, I'll get back to you...

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vM+IT2bz5yevw+4RAr5BAKCjHqDV5/bB6oXNLXYRgfxApbjfoQCdHF9t
WLNrC4ZExj3JWYZbyRFEVnk=
=Yg/N
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
