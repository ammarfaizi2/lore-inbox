Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSD2P0B>; Mon, 29 Apr 2002 11:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312570AbSD2P0A>; Mon, 29 Apr 2002 11:26:00 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:28682 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312560AbSD2PZ7>;
	Mon, 29 Apr 2002 11:25:59 -0400
Date: Mon, 29 Apr 2002 17:24:33 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.1{0,1}] VFS: Busy inodes after unmount...
Message-Id: <20020429172433.49ad5596.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.RpvNLtQ4VQupWM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.RpvNLtQ4VQupWM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
when rebooting or halting the system I get following message:
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

All filesystems are ReiserFS

Any ideas why there are busy inodes after umount?

Bye
--=.RpvNLtQ4VQupWM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8zWWze9FFpVVDScsRArbXAJ9PWvhVld1n/RBHiws12wSDFdKOHQCfbEyo
GF+3mGDrnvA568tIPwizAss=
=FtEk
-----END PGP SIGNATURE-----

--=.RpvNLtQ4VQupWM--

