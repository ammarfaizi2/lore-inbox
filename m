Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbSJNRIK>; Mon, 14 Oct 2002 13:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSJNRIK>; Mon, 14 Oct 2002 13:08:10 -0400
Received: from [209.184.141.189] ([209.184.141.189]:49705 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S262034AbSJNRII>;
	Mon, 14 Oct 2002 13:08:08 -0400
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submissi
	on
From: Austin Gonyou <austin@coremetrics.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-lvm@sistina.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021014171101.GA13897@suse.de>
References: <20021014171101.GA13897@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sb/lbbFC7MR1apOBjAOX"
Organization: Coremetrics, Inc.
Message-Id: <1034615636.29775.12.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 14 Oct 2002 12:13:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sb/lbbFC7MR1apOBjAOX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-14 at 12:11, Dave Jones wrote:
> On Mon, Oct 14, 2002 at 11:59:17AM -0500, Austin Gonyou wrote:
>  > Just curious, but device-mapper and 2.5.42 do not seem to jive very
>  > well. Please advise.
>=20
> You need device-jiver. Doubtful it'll make the freeze in time though.
> Seriously, what exactly does this bug report mean ?


Sorry..sorry...I'm saying that the recent device-mapper doesn't seem to
try to compile with 2.5.42, and was inquiring as to:=20
1. Is it not supposed to work yet?
2. Are there any patches, to make this work as yet?

#2 is one of the main reasons I'm responding to this thread. I'm an
interested party for testing LVM2 on 2.5, but can't seem to get there.
There was discussion about using EVMS, but well, it didn't seem to work
as seamlessly as LVM upgrades had, and I've not had the time to trouble
shoot it till later this week.


>                 Dave
>=20
> --=20
> | Dave Jones.        http://www.codemonkey.org.uk
--=20
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.

--=-sb/lbbFC7MR1apOBjAOX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9qvtU94g6ZVmFMoIRAghDAKC8/EPS96KWbYjEUgNEsYoCSbqrSACg4Qcb
8ekLX8MIVF7nX/ShhuHltPI=
=8eRQ
-----END PGP SIGNATURE-----

--=-sb/lbbFC7MR1apOBjAOX--
