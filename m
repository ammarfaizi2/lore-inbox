Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261933AbSJHK6H>; Tue, 8 Oct 2002 06:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbSJHK6H>; Tue, 8 Oct 2002 06:58:07 -0400
Received: from p508E88F3.dip.t-dialin.net ([80.142.136.243]:28128 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S261933AbSJHK6G>; Tue, 8 Oct 2002 06:58:06 -0400
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Tue, 8 Oct 2002 13:03:44 +0200
To: linux-kernel@vger.kernel.org
Subject: [BUG] DevFS broken in 2.5.41?
Message-ID: <20021008110343.GA1233@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while booting 2.5.41, i get the following error message:

Oct  7 22:46:32 minerva kernel: i2c-dev.o: i2c /dev entries driver module v=
ersion 2.6.4 (20020719)
Oct  7 22:46:32 minerva kernel: devfs_mk_dir(i2c): could not append to dir:=
 c153e7c0 "", err: -17
Oct  7 22:46:32 minerva kernel: Advanced Linux Sound Architecture Driver Ve=
rsion 0.9.0rc3 (Fri Oct 04 13:09:13 2002 UTC).

Is this a DevFS-related issue or is i2c somehow broken?

--=20
  .''`.   Name: Martin Loschwitz
 : :'  :  E-Mail: madkiss@madkiss.org
 `. `'`   www: http://www.madkiss.org/=20
   `-     Use Debian GNU/Linux - http://www.debian.org   =20

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9oruPHPo+jNcUXjARAuPDAKC1z6KzgbGTuBt6bdDbH8++BZG5HACgjYdL
lPjS/d5YKi8t0uG1Iw4xlYI=
=02z4
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
