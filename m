Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRBVC3O>; Wed, 21 Feb 2001 21:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbRBVC3E>; Wed, 21 Feb 2001 21:29:04 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:13816 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S130820AbRBVC27>;
	Wed, 21 Feb 2001 21:28:59 -0500
Date: Wed, 21 Feb 2001 18:32:36 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ext2 superblock issue on 2.4.1-ac20
Message-ID: <20010221183236.A396@turbolinux.com>
In-Reply-To: <20010221163514.A671@turbolinux.com> <E14VjyB-000391-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <E14VjyB-000391-00@the-village.bc.nu>; from Alan Cox on Thu, Feb 22, 2001 at 12:50:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

oops. sorry for the panic. my fault.
I was trying to boot a non-devfs'ed with devfs.
thanks anyway.

--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Who is John Galt?=20
of a GNU generation   -o)  |=20
Kernel 2.4.1-ac20     /\\  |=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------
On Thu, Feb 22, 2001 at 12:50:52AM +0000, Alan Cox wrote:
> > 	I just oldconfiged linux kernel with my 2.4.1 .config. When I boot the=
 new
> > 2.4.1-ac20 kernel, I get a message saying that my ext2 superblock is co=
rrup=3D
> > ted.
> > I get a message asking me to run e2fsck -b 8193 <...hdd dev..>
> > My 2.4.0-ac4 that I've been running for more than 2-3 weeks now has no =
prob=3D
> > lems
> > booting though.
> >=20
> > 	What am I doing wrong ? I would be glad to give more info.
>=20
> Sounds like a driver change broke the handling for your disks or re-order=
ed
> them.=20
>=20
> What hardware



--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lHpE5UrYeFg/7bURAh27AJ94KuCcW1clAj6XTTbew+9U8GbKtQCgu5Qb
ATWfkCQhqZEM9WLViKdZfoo=
=Top1
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
