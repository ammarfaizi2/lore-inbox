Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265071AbUBIL6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUBIL6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:58:21 -0500
Received: from [213.69.232.58] ([213.69.232.58]:46344 "HELO
	mobilemail.schottelius.org") by vger.kernel.org with SMTP
	id S265071AbUBIL6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:58:19 -0500
Date: Mon, 9 Feb 2004 12:58:52 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040209115852.GB877@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
X-MSMail-Priority: (u_int) -1
X-Mailer: echo $message | gpg -e $sender  -s | netcat mailhost 25
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Morning!

What Linux supported filesystems support UTF-8 filenames?

Looks like at least xfs and reiserfs are not able of handling them,
as Apache with UTF-8 as default charset delievers wrong names, when
accessing files with German umlauts.

Is it somehow planned to enable it?
Or are you waiting for patches which do that job?

Greetings,

Nico

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJ3X8zGnTqo0OJ6QRAl+WAKCD2uaIquzEuMzz3WjSVRuPzwckJQCcDVHd
gBTmkIzR1/UtKa8Wnx0Cqs0=
=L/cL
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
