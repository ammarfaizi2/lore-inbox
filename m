Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSKRM5Z>; Mon, 18 Nov 2002 07:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSKRM5M>; Mon, 18 Nov 2002 07:57:12 -0500
Received: from ppp-217-133-216-163.dialup.tiscali.it ([217.133.216.163]:24966
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262481AbSKRM41>; Mon, 18 Nov 2002 07:56:27 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037625619.7547.6.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0211181322281.1639-100000@localhost.localdomain>
	 <1037625619.7547.6.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-/POcDNG2ZXMpGcvGYl5D"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Nov 2002 14:03:12 +0100
Message-Id: <1037624592.1774.143.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/POcDNG2ZXMpGcvGYl5D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

VM_DONTCOPY means that the vma is ignored when the mm is duplicated as a
result of fork or clone without CLONE_VM.
See kernel/fork.c:239


--=-/POcDNG2ZXMpGcvGYl5D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92OUQdjkty3ft5+cRAnM/AKDa97OtNhIViP0jjpCcnmwNZks/KgCfSRnZ
mCrg0b3iR7sB4aFxBB2VpwY=
=kJi7
-----END PGP SIGNATURE-----

--=-/POcDNG2ZXMpGcvGYl5D--
