Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbQJ3H2D>; Mon, 30 Oct 2000 02:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129114AbQJ3H1w>; Mon, 30 Oct 2000 02:27:52 -0500
Received: from wiiusc.wii.ericsson.net ([192.36.108.17]:21062 "EHLO
	hell.wii.ericsson.net") by vger.kernel.org with ESMTP
	id <S129071AbQJ3H1i>; Mon, 30 Oct 2000 02:27:38 -0500
Message-Id: <200010300727.IAA12250@hell.wii.ericsson.net>
X-Mailer: exmh version 2.2_20001026 06/23/2000 with nmh-1.0.3
To: linux-kernel@vger.kernel.org
From: Anders Eriksson <aer-list@mailandnews.com>
Subject: / on ramfs, possible?
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_17293564P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Oct 2000 08:27:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_17293564P
Content-Type: text/plain; charset=us-ascii


I want my / to be a ramfs filesystem. I intend to populate it from an 
initrd image, and then remount / as the ramfs filesystem. Is that at 
all possible? The way I see it the kernel requires / on a device 
(major,minor) or nfs.

Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?

/Anders




--==_Exmh_17293564P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: Exmh version 2.2_20000822 06/23/2000

iD8DBQE5/SLi/X4RQObd8qERAlS3AJ0c4gDkwVxsIMZGcuXXXEV/ID4TuACglQh5
0f8CRp7dH3/Wc6D/ge1j164=
=ucbp
-----END PGP SIGNATURE-----

--==_Exmh_17293564P--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
