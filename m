Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRJGB3U>; Sat, 6 Oct 2001 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275994AbRJGB3J>; Sat, 6 Oct 2001 21:29:09 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:41090 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S275990AbRJGB3A>; Sat, 6 Oct 2001 21:29:00 -0400
Date: Sat, 6 Oct 2001 20:29:28 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.11-pre4, extremely long umount times
Message-ID: <20011006202928.C749@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm running 2.4.11-pre4 with the ext3 patch and Andrew Morton's low-latency
patch on an alpha LX164.

umount times are extremely long (> 30 minutes) for both ext2 and ext3
filesystems, though they eventually succeed.

Is this a known problem?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAju/r/gACgkQjwioWRGe9K1onQCg9UZxSDGVmi6YIGqFuo9hg8rx
83gAoKV1PxuaI4RUbxab9TiHJuUzZI5+
=a+to
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
