Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRBFOZG>; Tue, 6 Feb 2001 09:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRBFOY4>; Tue, 6 Feb 2001 09:24:56 -0500
Received: from wiiusc.wii.ericsson.net ([192.36.108.17]:6208 "EHLO
	hell.wii.ericsson.net") by vger.kernel.org with ESMTP
	id <S129400AbRBFOYX>; Tue, 6 Feb 2001 09:24:23 -0500
Message-Id: <200102061424.PAA32284@hell.wii.ericsson.net>
X-Mailer: exmh version 2.2_20001214 06/23/2000 with nmh-1.0.3
To: linux-kernel@vger.kernel.org
From: Anders Eriksson <aer-list@mailandnews.com>
Subject: sync & asyck i/o 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1995718836P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Feb 2001 15:24:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1995718836P
Content-Type: text/plain; charset=us-ascii


According to the man page for fsync it copies in-core data to disk 
prior to its return. Does that take async i/o to the media in account? 
I.e. does it wait for completion of the async i/o to the disk?

/Anders



--==_Exmh_-1995718836P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: Exmh version 2.2_20000822 06/23/2000

iD8DBQE6gAkL/X4RQObd8qERAg0kAJ9it8YKHSQxlpfLbzaeV4oJV/L8cwCcCD1L
hO5tlD2KhiDXds1JXMb8BCk=
=5zM4
-----END PGP SIGNATURE-----

--==_Exmh_-1995718836P--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
