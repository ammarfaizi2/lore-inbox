Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTBDJ0M>; Tue, 4 Feb 2003 04:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTBDJ0M>; Tue, 4 Feb 2003 04:26:12 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:18415 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267184AbTBDJ0L>; Tue, 4 Feb 2003 04:26:11 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044312846.28406.31.camel@imladris.demon.co.uk>
References: <1044284924.2402.12.camel@gregs>
	 <1044289102.21009.1.camel@irongate.swansea.linux.org.uk>
	 <1044286828.2397.26.camel@gregs>
	 <1044292722.21009.9.camel@irongate.swansea.linux.org.uk>
	 <1044312846.28406.31.camel@imladris.demon.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VV4TzVMHmcL6X9wEh8rF"
Organization: Red Hat, Inc.
Message-Id: <1044351340.1421.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Feb 2003 10:35:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VV4TzVMHmcL6X9wEh8rF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-03 at 23:54, David Woodhouse wrote:

> GCC is likewise perfectly entitled to use floating point even if you
> only used integers in the source. There's a good reason why the SH port
> builds with '-mno-implicit-fp' and why all other ports should have this
> _before_ it becomes a problem rather than afterwards.

I'm sorry, but it seems you forgot to use the -u option in your diff.

--=-VV4TzVMHmcL6X9wEh8rF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+P4lrxULwo51rQBIRAtzKAJ0QrrFhM0yyVRMYNET1joB20z8TsgCdGFCr
ibCsmRT4oCUuA0qCB0JTbBE=
=Xseh
-----END PGP SIGNATURE-----

--=-VV4TzVMHmcL6X9wEh8rF--
