Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSHDVPe>; Sun, 4 Aug 2002 17:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318232AbSHDVPe>; Sun, 4 Aug 2002 17:15:34 -0400
Received: from dialin-145-254-149-035.arcor-ip.net ([145.254.149.35]:19182
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id <S318231AbSHDVPd>; Sun, 4 Aug 2002 17:15:33 -0400
Date: Sun, 4 Aug 2002 07:37:06 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: floppy issue also in 2.4.18 ?  / 2.5 solution
Message-ID: <20020804053705.GA9854@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again!

The floppy driver and me just married...
Two questions [hopefully first last]:

1) Why does 2.4.18 kernel hangs when I try to boot it from floppy ?
   Symptoms: After 'Loading ... ' progress finished, the disk drive's
   led is still lighting and nothing happens anymore.
   What can be wrong ? CPU is correct (I even tried 386,586,p-classic,p-mmx=
,..),
   it's a P133. And howto fix it?

2) Somebody explain me what changed in vfs, where to find doc and give me s=
ome
   time to fix that damn 2.5 floppy driver. I'm gonna fight it.

3) oops, one more: Can somebody else please fix the apm issue ?

Sincerly,

Nico /* tired, but alive */

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9TL2BtnlUggLJsX0RAsJIAJ4kGnj7Wvsyfmin4V6ezfQNNvB9NgCgjWgf
wM0liKs78tHg9nFU8sKob/4=
=FD8X
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
