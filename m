Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSBGNEh>; Thu, 7 Feb 2002 08:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSBGNE1>; Thu, 7 Feb 2002 08:04:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:24493 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291049AbSBGNEQ>;
	Thu, 7 Feb 2002 08:04:16 -0500
Date: Thu, 7 Feb 2002 14:07:45 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Next "Problem" with ReiserFS: vs-825: reiserfs_get_block: [799572 866493 0x3001 UNKNOWN] should not be found
Message-Id: <20020207140745.52eebb57.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="mg?X'kXPQBzx9=.t"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--mg?X'kXPQBzx9=.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
I'm currently running 2.5.3-dj3 with the "fix for inodes with wrong item versions" and got the following errors in dmesg:
vs-825: reiserfs_get_block: [283508 198 0x19001 UNKNOWN] should not be found
[many times]
and after a while:
vs-825: reiserfs_get_block: [799572 866493 0x3001 UNKNOWN] should not be found
[many times]

What does this mean?

Bye
--mg?X'kXPQBzx9=.t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8Ynwke9FFpVVDScsRAgJFAKCPOt/fcOzwYzJ9d3OtHhXPuIscVQCgh19H
toZ6mL2S5fH8/i3Cq/96b4E=
=D3xf
-----END PGP SIGNATURE-----

--mg?X'kXPQBzx9=.t--

