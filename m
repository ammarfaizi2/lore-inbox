Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263583AbSITVQp>; Fri, 20 Sep 2002 17:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263592AbSITVQp>; Fri, 20 Sep 2002 17:16:45 -0400
Received: from ppp-217-133-217-84.dialup.tiscali.it ([217.133.217.84]:37084
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S263583AbSITVQo>; Fri, 20 Sep 2002 17:16:44 -0400
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
From: Luca Barbieri <ldb@ldb.ods.org>
To: Roland McGrath <roland@redhat.com>
Cc: phil-list@redhat.com, Ulrich Drepper <drepper@redhat.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <200209201840.g8KIehO28302@magilla.sf.frob.com>
References: <200209201840.g8KIehO28302@magilla.sf.frob.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-1cvv/wvd3VO896ds18pL"
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 23:21:45 +0200
Message-Id: <1032556905.11424.333.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1cvv/wvd3VO896ds18pL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Try that under -fpic and you will see the problem.
Unfortunately it tries to get it using the GOT and I can't find any
practical workaround, so ignore my broken suggestion.


--=-1cvv/wvd3VO896ds18pL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9i5Fpdjkty3ft5+cRAghCAJ4yQmuMy2bTeQx7TmNQ3WUbB+8JLgCfVX7c
MNOhtl8uSX715xiJXf5nWPc=
=GEky
-----END PGP SIGNATURE-----

--=-1cvv/wvd3VO896ds18pL--
