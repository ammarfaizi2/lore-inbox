Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUGQXWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUGQXWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGQXUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:20:39 -0400
Received: from tullahoma-24-159-22-9.midtn.chartertn.net ([24.159.22.9]:39811
	"EHLO joseph-a-nagy-jr.homelinux.org") by vger.kernel.org with ESMTP
	id S262391AbUGQXT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 19:19:26 -0400
Date: Sat, 17 Jul 2004 18:19:19 -0500
From: "Joseph A. Nagy, Jr." <jnagyjr@joseph-a-nagy-jr.homelinux.org>
To: Ciaran McCreesh <ciaranm@gentoo.org>
Cc: augustus@linuxhardware.org, linux-kernel@vger.kernel.org, tseng@gentoo.org
Subject: Re: vim doesn't like the command line
Message-ID: <20040717231919.GC14247@joseph-a-nagy-jr.homelinux.org>
References: <Pine.LNX.4.58.0407142340560.7017@penguin.linuxhardware.org> <20040717233654.102579e1@snowdrop.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20040717233654.102579e1@snowdrop.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 17, 2004 at 11:36:54PM +0100, Ciaran McCreesh wrote the followi=
ng:
> On Wed, 14 Jul 2004 23:44:16 -0400 (EDT) augustus@linuxhardware.org
> wrote:
> | This is odd but it seems that vim 6.3 does not function properly with=
=20
> | kernel 2.6.8-rc1.  It will not take command line arguement filenames.=
=20
> | No matter what you pass it, it always goes to the file browser.  This
> | is not the case with 2.6.7 kernels.  Any ideas?  I have attached my
> | kernel .config.
>=20
> I've been trying to track this down as well. Kinda tricky, since it
> WORKSFORME(TM). The following may be of help to you:
>=20
> http://bugs.gentoo.org/show_bug.cgi?id=3D57378
>=20
> Basically, argv is getting nuked by something.
>=20
> Seems rebuilding without a -march in CFLAGS fixes it for some people,
> reason unknown...
>=20
> --=20
> Ciaran McCreesh : Gentoo Developer (Sparc, MIPS, Vim, Fluxbox)
> Mail            : ciaranm at gentoo.org
> Web             : http://dev.gentoo.org/~ciaranm
>=20

With a $40/person insurance payment (if the box is totally nuked and requir=
es
a reinstall), I'd be willing to give shell accounts (with root access) to
anyone who wants to check out my environment and try some tweaking.

If the box doesn't get nuked the $40 will be returned to each person.

--=20
AIM: pres CTHULHU | ICQ: 18115568 | Yahoo: pagan_prince
Jabber: DarkKnightRadick@(jabber.org|amessage.at) | Libertarian @ Large
PGP: 0x642F7BDA | < http://groups.yahoo.com/group/tennesseans-for-badnarik/=
 >
< http://mc-luug.homelinux.org/mailman/listinfo/mc-luug >

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+bP26i+npmQve9oRAi4YAKCv2cpB9iXSrCvt59fdhIF4XIWXMACfdtit
d4uldOsB2LGM9Zh+J/ctPKk=
=xcmc
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
