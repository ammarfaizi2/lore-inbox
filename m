Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUA0TkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUA0TkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:40:06 -0500
Received: from mail-in.m-online.net ([62.245.150.237]:8942 "EHLO
	mail-in.m-online.net") by vger.kernel.org with ESMTP
	id S265659AbUA0Tj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:39:56 -0500
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
From: Florian Huber <florian.huber@mnet-online.de>
To: JFS-Discussion <jfs-discussion@oss.software.ibm.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, shaggy@austin.ibm.com
In-Reply-To: <1075231718.21763.28.camel@shaggy.austin.ibm.com>
References: <1075230933.11207.84.camel@suprafluid>
	 <1075231718.21763.28.camel@shaggy.austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zA01jpw6+I2o5PTUVhVp"
Message-Id: <1075232395.11203.94.camel@suprafluid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 20:39:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zA01jpw6+I2o5PTUVhVp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-27 at 20:28, Dave Kleikamp wrote:
> I wonder if JFS is having trouble getting the partition size.  Can you
> run jfs_fsck with the -v flag to see what part of the superblock it
> doesn't like?

The current device is:  /dev/md2
Open(...READ/WRITE EXCLUSIVE...) returned rc =3D 0
Incorrect jlog length detected in the superblock (P).
Incorrect jlog length detected in the superblock (S).
Superblock is corrupt and cannot be repaired=20
since both primary and secondary copies are corrupt. =20

--=20
Florian Huber

Key ID: D9D50EA2
Fingerprint: 0241 C329 E355 9B94 8D34 F637 4EB9 1B1D D9D5 0EA2

BOFH Excuse #147:
Party-bug in the Aloha protocol.

--=-zA01jpw6+I2o5PTUVhVp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFr6LTrkbHdnVDqIRAqTNAJ9MW4XoAc0umYgJXGx7k36NGu2DQwCbBtG0
Hy2yC6jwQbVOr6bE73p3Uqc=
=IIf4
-----END PGP SIGNATURE-----

--=-zA01jpw6+I2o5PTUVhVp--

