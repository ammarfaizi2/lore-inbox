Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSJVUGY>; Tue, 22 Oct 2002 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbSJVUGX>; Tue, 22 Oct 2002 16:06:23 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:45294 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264795AbSJVUGW>; Tue, 22 Oct 2002 16:06:22 -0400
Subject: Re: I386 cli
From: Arjan van de Ven <arjanv@redhat.com>
To: David Grothe <dave@gcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20021022145759.02861ec8@localhost>
References: <5.1.0.14.2.20021022145759.02861ec8@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ZSlzj/8NB2Ml/mjxsjsm"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 22:14:45 +0200
Message-Id: <1035317685.3002.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZSlzj/8NB2Ml/mjxsjsm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-22 at 22:01, David Grothe wrote:
> In 2.5.41every architecture except Intel 386 has a "#define cli=20
> <something>" in its asm-arch/system.h file.  Is there supposed to be such=
 a=20
> define in asm-i386/system.h?  If not, where does the "official" definitio=
n=20
> of cli() live for Intel?  Or what is the include file that one needs to=20
> pick it up?  I can't find it.

cli no longer exists in the kernel
the other architectures have a broken definition probably that needs to
go away as well.




--=-ZSlzj/8NB2Ml/mjxsjsm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9tbG0xULwo51rQBIRAm1aAKCOVOiot8gPvG51cDY4ka8pyG3jtgCgoDLZ
Dn8GXx/r43F9+vKhavw05P4=
=Elq/
-----END PGP SIGNATURE-----

--=-ZSlzj/8NB2Ml/mjxsjsm--

