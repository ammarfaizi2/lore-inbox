Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262673AbTDAQll>; Tue, 1 Apr 2003 11:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTDAQlk>; Tue, 1 Apr 2003 11:41:40 -0500
Received: from B580e.pppool.de ([213.7.88.14]:36251 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262673AbTDAQlj>; Tue, 1 Apr 2003 11:41:39 -0500
Subject: Re: flash as hda causes 2.4.18 to hang in
	grok_partitions()...add_to_page_cache_unique()
From: Daniel Egger <degger@fhm.edu>
To: David Wuertele <dave-gnus@bfnet.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <m3smt3xuo1.fsf@bfnet.com>
References: <m3smt3xuo1.fsf@bfnet.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ylUQ256XrvQE7G7GmrYN"
Organization: 
Message-Id: <1049212755.7628.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 17:59:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ylUQ256XrvQE7G7GmrYN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2003-03-31 um 20.22 schrieb David Wuertele:

> I've got a mipsel linux 2.4.18 system that has a compact flash IDE
> disk as hda.  For some reason, in grok_partitions, the kernel goes
> bye-bye.  I've traced it as far as read_page_cache().

I'd say this is a platform specific bug as it works for me under 2.4.18
on ppc and i386.

--=20
Servus,
       Daniel

--=-ylUQ256XrvQE7G7GmrYN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ibdTchlzsq9KoIYRAhu1AKDbcHRZ4bkomP8waWuTXDnUZ/S42ACfaX4c
f7ulQQHjiBXsZAGOnsQiliM=
=eLOj
-----END PGP SIGNATURE-----

--=-ylUQ256XrvQE7G7GmrYN--

