Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266140AbUFIOVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUFIOVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFIOVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:21:38 -0400
Received: from [213.69.232.58] ([213.69.232.58]:63497 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S266136AbUFIOVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:21:19 -0400
Date: Wed, 9 Jun 2004 16:23:52 +0200
From: Nico Schottelius <nico-linux-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: [Problem] usb-storage, transfering much data
Message-ID: <20040609142352.GF1390@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-linux-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
X-MSMail-Priority: (u_int) -1
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am trying to copy my old harddisk with dd to an usb disk.
On no Linux system does that work. I looks like transfering
much data from/to the usb disks stops it from using. When reconnecting
it works again.

I see this error with any usb hard disks with different cases.

Is this know to you? Can I help to debug it?

The error is attached from dmesg.=20


Nico

ps: please cc


ailure occurred trying to find stat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find s=
tat data of [4669 4670 0x0 SD]
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nerd-hosting.net | http://nico.schotteli.us

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQMcddrOTBMvCUbrlAQIuAg/+MdQlf9N25h1YFKax5xnvN0f8lg3yHCws
Zsm75scWGCtkkm0pOfBI+EoR7ui/2TPG/bmQlbZVNw3HFtZTViWzb4GWl1PxxQXV
S2iACcWgPS6UDtBmNcT6WO6ojycpyPupmc0FBoGzhi6mi37LuD0I9OczwgBLYj9Q
o5dddVDR/smiIAOAjZrDbmwOc0gfuUfovFQPS4j+/JTqHdXr74L4dhLDXNcMrOJB
QJ+JkbG8XYsMN81LbdaBc4IUEhQWiCitE9rCjFF9lbn2iQWILs8FtMwfyeGnKEHk
F8q+DKcK26PGmckdQs8g9fYPrk1QXuVhbNYJiYZ9kinw14l+03f+Kj4zr0HBzNaE
sJtls5lnAedTsd3drgNaEruUrh7bNeVR68RC+EegVJuXJ+uTdKmah8973mB+v8oC
O5HcgODHl8zNQb1ZyHvnfQiOjESmVHUiSVP1uxrdSqeXTKFl6Oj6uMkA56hwio0K
Bg1l/WJiuJnDthQcI0YLNl/I/HtSRSYRCfpflHWMhgGIiSPcEh9fD2/kuPaHTiLc
LFS8OATCc1ebQOOITX4Oi0O3tUUdxC062zOW1Y7+nJxC2qmTkS1yL6WBGmgwY6hJ
qCpbsB/LXilcjnotNkAMEFttRkp81Zp1Z8/qhWBO2F03hKa/3oC5FGqnsH63Dgux
+5rkyuUy7Dc=
=OeBP
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
