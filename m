Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276317AbRI1VfA>; Fri, 28 Sep 2001 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276321AbRI1Veu>; Fri, 28 Sep 2001 17:34:50 -0400
Received: from h24-76-184-239.vs.shawcable.net ([24.76.184.239]:50566 "HELO
	md5.ca") by vger.kernel.org with SMTP id <S276317AbRI1Vej>;
	Fri, 28 Sep 2001 17:34:39 -0400
Date: Fri, 28 Sep 2001 14:32:05 -0700
From: Pavel Zaitsev <pavel@md5.ca>
To: linux-kernel@vger.kernel.org
Subject: kernel changes
Message-ID: <20010928143205.B3669@md5.ca>
Reply-To: pavel@md5.ca
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,
I have been watching development of 2.4 since 2.4.2, I wonder wether
there would be reversion to old process where kernel source will be
solidified before starting development branch. Sysadmins where I work
are uneasy to move to linux from solaris, because of erratic changes
to the kernel such as replacement of the hardware monitoring code, rewriting
of network card drivers - all of which broke some or other software,
or simply did not work. I myself update kernel as time permits,
usually every 0.0.2+ I have spent nearly two days tracing problem
of my network, that ended up in source code of the driver that have
been radically changed for "better". Now I don't trust 2.4 line
kernel to work *at all*, so cautiously keep all old kernels in the /boot,
when upgrading.
It seems I am not only one and wonder if something will be done about that.
Regards,
p.

--=20
Research causes cancer in rats.
110461387
http://gpg.md5.ca
http://perlpimp.com

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7tOxVEhbFhd1U3E0RAg8qAJ4xvR3vTDQq3L0zR6A7YO566yCXmwCfZnqE
epv1aoyy7jdGYCWPm0WAkqo=
=6Cyv
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
