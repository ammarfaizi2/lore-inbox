Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTA1Nvr>; Tue, 28 Jan 2003 08:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTA1Nvr>; Tue, 28 Jan 2003 08:51:47 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:1431 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S265423AbTA1Nvq>;
	Tue, 28 Jan 2003 08:51:46 -0500
Date: Tue, 28 Jan 2003 09:01:03 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 3ware error?  WTF is this?
Message-ID: <20030128140103.GE13105@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Guys, I've got a machine generating all kinds of wierd errors.  It
failed 4 out of 8 drives on a 3ware card.  A reboot cleared all but 1
up, I've had alot of lag while the card is spitting errors etc.  I'm
about to launch this thing into the nearest highway I can find.

This morning I got this:

3w-xxxx: scsi1: PCI Parity Error: clearing.
EXT3-fs error (device md(9,2)): ext3_add_entry: bad entry in directory
#65: rec_len % 4 !=3D 0 - offset=3D552, inode=3D93, rec_len=3D21, name_len=
=3D11
3w-xxxx: scsi2: PCI Parity Error: clearing.


Can I get an educated "oh, your card is bad" or "hmm, bad driver maybe?"
or something I can poke with a stick?  It's a brand new box with brand
new drives and controllers.  It was running great until last week.
Kernel 2.4.19 with 3ware driver 7.5.2 from their web page.

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                              =20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=3Dpack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10)=
;'


--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+No0fPvY/pfyW1AURAqn6AJ4vvGBYKRzwJMKmyN7TUHnXeyT44QCglYJI
sG9dnw9uROlBoaxWMFS3YgI=
=pJnT
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
