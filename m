Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSASS0L>; Sat, 19 Jan 2002 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbSASS0C>; Sat, 19 Jan 2002 13:26:02 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:57618 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S286758AbSASSZx>; Sat, 19 Jan 2002 13:25:53 -0500
Date: Sat, 19 Jan 2002 19:27:57 +0100
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: Usage of filetype
Message-ID: <20020119192756.Z3627@mandel.hjb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="QUHshEHhcC66g79u"
Content-Disposition: inline
User-Agent: Mutt/1.3.13-current-20010108i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QUHshEHhcC66g79u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in the tune2fs manual I found the ext2 option 'filetype'. A file type seems
to be an 8 bit number, defined in linux/dirent.h in struct dirent64.
However, I didn't find any further docs about it, and I don't know any
userspace tools to read/set it. Could anyone please point me to more info
(or explain if this feature has any use)?

Thanks,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--QUHshEHhcC66g79u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment:  

iD8DBQE8SbqpLbySPj3b3eoRAqC1AJ4wetZyxd4YpSl5qc3Rh9HS4E5f4wCfbvIW
v3+Am8CkpziKt5s5tyzV0W8=
=wVk9
-----END PGP SIGNATURE-----

--QUHshEHhcC66g79u--
