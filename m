Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUIVJdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUIVJdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 05:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIVJdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 05:33:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23722 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262605AbUIVJdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 05:33:35 -0400
Subject: Re: FUSE fusexmp proxy example solves umount problem!
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040922004941.GC14303@lkcl.net>
References: <20040922004941.GC14303@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5izmu5A37EXwJTTcRzf/"
Organization: Red Hat UK
Message-Id: <1095845610.2613.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 22 Sep 2004 11:33:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5izmu5A37EXwJTTcRzf/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-22 at 02:49, Luke Kenneth Casson Leighton wrote:
> what do people think about a filesystem proxy kernel module?
> has anyone heard of such a beast already?
> (which can also do xattrs)
>=20
> fusexmp.c (in file system in userspace package) does stateless
> filesystem proxy redirection.
>=20
> this is a PERFECT solution to the problem of users removing media
> from drives without warning.=20

eh and the 2.6 kernel doesn't deal with it? It really is supposed to
deal with it nicely already...

--=-5izmu5A37EXwJTTcRzf/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBUUbqxULwo51rQBIRApOuAJ9ofF+DpIH0c61g3GQtcblaXjCURwCgoDED
L08ZpZEGxvMP0+YWSUW9peY=
=n0rR
-----END PGP SIGNATURE-----

--=-5izmu5A37EXwJTTcRzf/--

