Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSHCOIM>; Sat, 3 Aug 2002 10:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSHCOIM>; Sat, 3 Aug 2002 10:08:12 -0400
Received: from dialin-145-254-144-235.arcor-ip.net ([145.254.144.235]:18670
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S317576AbSHCOIL>; Sat, 3 Aug 2002 10:08:11 -0400
Date: Sat, 3 Aug 2002 07:06:34 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.29 / 2.5.31 floppy/apm support
Message-ID: <20020803050633.GA459@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello guys!

Just a small question, perhaps it's dump, but I am having big problems=20
currently:

I want to setup a router-only host, which boots from two floppy drives
and has 3 network devices.

So far no problem, but when trying to access the ramdisk on the floppy,
the old problem exists that the floppy driver does not work with current
VFS.

Then I tried to shutdown the host via network, which fails because of apm
module cannot be included in kernel in 2.5.29.

So I just wanted to ask, whether someone is working on the floppy and apm
problem or if it is / will be solved in 2.5.31 ?

Nico

/* a bit frustrated, because the wifi card only works correct in 2.5 series,
   which let 2.5 the only choice.
   Perhaps I am gonna use 2.5.24, which was pretty stable and still had apm=
 and
   floppy support...
*/
  =20

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9S2TZtnlUggLJsX0RAi4xAJ4wX1FPhJ3o2Om/91u8G3lu5wtzmwCfbjST
z+J3dk1G2kSSBU9mjXeu0i8=
=qk5A
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
