Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbRGOABr>; Sat, 14 Jul 2001 20:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265199AbRGOABh>; Sat, 14 Jul 2001 20:01:37 -0400
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:29276
	"EHLO darklands.localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265277AbRGOABX>; Sat, 14 Jul 2001 20:01:23 -0400
Date: Sat, 14 Jul 2001 17:01:13 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Message-ID: <20010714170113.A12617@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <3B50DBAE.7030406@lycosmail.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux darklands 2.4.7-pre6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14-Jul 07:54, Adam Schrotenboer wrote:
> Sorry if this is a repost.
>=20
> I am upgrading to a new 36GB HD, and intend to split it into 3 pieces:=20
> one 7GB vfat, one ~28GB linux data (reiser or ext2), and 1GB swap.
>=20
> I need to know if I can trust ReiserFS, as I do believe that I do want=20
> ReiserFS.

I have never lost data on ReiserFS. Infact, /usr shrunk by ~20megs changing
from ext2 to reiserfs.

Thomas

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7UN1JUHPW3p9PurIRAkyXAJ41EbtX1C1kEAK0+3nzGdsa0/usbwCfWcTQ
aMCLG/J3rPbL3UfiuIKVG4k=
=uFRc
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
