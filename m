Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbTC0CsD>; Wed, 26 Mar 2003 21:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTC0CsD>; Wed, 26 Mar 2003 21:48:03 -0500
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:19680
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262788AbTC0CsC>; Wed, 26 Mar 2003 21:48:02 -0500
Date: Wed, 26 Mar 2003 18:59:14 -0800
To: linux-kernel@vger.kernel.org
Cc: jt@hpl.hp.com
Subject: WE16 patch for 2.5.66
Message-ID: <20030327025914.GA1035@firesong>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It's me again, since my old patch started failing in net/netsyms.c.
So anyway, this patch will cleanly update your Wireless Extension
to version 16, diffed against the vanilla 2.5.66 kernel.

You can retrieve it at:
http://triplehelix.org/~joshk/linux/we15_2.5.66-we16.patch.bz2

It is best used with wireless-tools 26-pre7, to take advantage of
what WE16 actually does different from v15 which is already in the
kernel.

This is obviously still in testing, since Jean hasn't had it merged
with the main tree. Use at your own risk. :)

Regards
Josh



--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gmkCT2bz5yevw+4RAnymAJ9Z7rCGsrQqqPFqzSg6i4mLqs/YPgCeNvBW
qhjTb9eGdfE4dCoOR6LBnVk=
=VqQP
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
