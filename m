Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTIBLVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTIBLVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:21:13 -0400
Received: from [213.69.232.58] ([213.69.232.58]:47370 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S261186AbTIBLVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:21:10 -0400
Date: Tue, 2 Sep 2003 13:18:46 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: bastian@schottelius.org
Subject: [2.6.0] ramdisk rd.o problems with devfs
Message-ID: <20030902111846.GA9257@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bastian@schottelius.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

When using modprobe rd I got no new devices under /dev.
Shouldn't be /dev/ram/X created?
Are there any known bugs in 2.6.0 ramdisk, which makes it=20
impossible to boot from initrd?
Are there changes to the 2.4 initrd?

Sincerly,
Nico

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.=
new
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/VHyWzGnTqo0OJ6QRAh7bAKDQapMVYXkDoHcimJlXrnR1XnOZVwCgtcz7
hX1JE3FXAbfnWT00+CL2Wmk=
=EHXA
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

When using modprobe rd I got no new devices under /dev.
Shouldn't be /dev/ram/X created?
Are there any known bugs in 2.6.0 ramdisk, which makes it=20
impossible to boot from initrd?
Are there changes to the 2.4 initrd?

Sincerly,
Nico

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.=
new
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/VHyWzGnTqo0OJ6QRAh7bAKDQapMVYXkDoHcimJlXrnR1XnOZVwCgtcz7
hX1JE3FXAbfnWT00+CL2Wmk=
=EHXA
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
