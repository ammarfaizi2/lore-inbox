Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268094AbTBMRTV>; Thu, 13 Feb 2003 12:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268095AbTBMRTV>; Thu, 13 Feb 2003 12:19:21 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:57225 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S268094AbTBMRTU>;
	Thu, 13 Feb 2003 12:19:20 -0500
Subject: How to bypass buffer caches?
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9QGkc6zsPmgaNZwu0VOV"
Organization: Rutgers University
Message-Id: <1045157351.21195.134.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Feb 2003 12:29:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9QGkc6zsPmgaNZwu0VOV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've sent some messages about using O_DIRECT to read files, but I
suppose that is not possible using 2.4 kernel and ext2. So I was
wondering which other alternatives I have to bypass the buffer cache of
the kernel. One option would be create a raw device on top of my disk
partition, but in this case I would have to learn how to map a logical
file name (/var/tmp/myfile) to a set of block disks. Is there any other
solution? Can I disable buffer caches or at least limit their memory
utilization?

Thanks,

Bruno.
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-9QGkc6zsPmgaNZwu0VOV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+S9XmZGORSF4wrt8RApiXAJ9mqMpQHB0uK0zG7QjFm59O2MIzywCfSEZA
K90e4RGsVuChx86w9g19/AE=
=mKgs
-----END PGP SIGNATURE-----

--=-9QGkc6zsPmgaNZwu0VOV--

