Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTAGRaM>; Tue, 7 Jan 2003 12:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAGRaM>; Tue, 7 Jan 2003 12:30:12 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:59882 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id <S267431AbTAGRaD>;
	Tue, 7 Jan 2003 12:30:03 -0500
Subject: Re: Undelete files on ext3 ??
From: Max Valdez <maxvaldez@yahoo.com>
To: Jan Hudec <bulb@ucw.cz>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107094547.GG2141@vagabond>
References: <200301070859.h078xEnI000337@darkstar.example.net>
	 <Pine.LNX.4.44.0301071004550.30728-100000@dns.toxicfilms.tv>
	 <20030107094547.GG2141@vagabond>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FHXBZBTc8T2FBwjhwe3q"
Organization: 
Message-Id: <1041961118.13635.10.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Jan 2003 11:38:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FHXBZBTc8T2FBwjhwe3q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> By the way, there used to be undelete tool for ext2. It created a list
> of deleted inodes with correct stat, but no names, only their inode
> numbers. You could then pick the corect inode and give it a name, thus
> bringing it back to life. Since ext3 is just ext2 with journal, I guess
> it might work. It existed as a standalone tool and integrated to
> midnight commander.
>=20
I think there must be some other differences between ext2 and ext3, I've
tryed e2undel and unrm, both made for ext2, and none of them found any
deleted inode.

I umonted immediately the drive, and nothing has been writen on it after
the rm *

Thanks for the comments !
I will keep searching !
Max
--=20
uname -a: Linux garaged.fis.unam.mx 2.4.20-rc2-ac3 #2 SMP Thu Nov 21 17:15:=
31 UTC 2002 i686 unknown unknown GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
GS/ d-s:a-C++ILIHA+++P-L++E--W++N+K-w++++O-M--V--PS+PEY+PGP-tXRtv++b+DI--D+=
Ge++h---r+++z+++
-----END GEEK CODE BLOCK-----
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-FHXBZBTc8T2FBwjhwe3q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+GxCesvQlVyd+QikRAoZlAKCBHOyW8/SUhs/1kePwbOjlARLQ4ACfWuhR
+q6/elxjyZtfh5auo5PGQig=
=mSdv
-----END PGP SIGNATURE-----

--=-FHXBZBTc8T2FBwjhwe3q--

