Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263161AbTCSSQR>; Wed, 19 Mar 2003 13:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263166AbTCSSQR>; Wed, 19 Mar 2003 13:16:17 -0500
Received: from splat.lanl.gov ([128.165.17.254]:21391 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S263161AbTCSSQP>; Wed, 19 Mar 2003 13:16:15 -0500
Date: Wed, 19 Mar 2003 11:23:55 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Matthias Schniedermeyer <ms@citd.de>,
       "Richard B. Johnson" <johnson@quark.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Everything gone!
Message-ID: <20030319182354.GP832@lanl.gov>
References: <Pine.LNX.4.53.0303191041370.27397@quark.analogic.com> <20030319160437.GA22939@citd.de> <1048091858.989.10.camel@bip.localdomain.fake> <Pine.LNX.4.53.0303191158180.31905@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303191158180.31905@chaos>
User-Agent: Mutt/1.4i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, I couldn't help but try it. I've got a 2G bochs disk image for Debian
(really a 250M holey file) I can copy and throw away.

A `rm -rfv *` as root from / does:

(removes a bunch of files, including "rm" from bin and so forth), then loop=
s printing:
removing all entries of directory `dev/pts'
removing the directory itself `dev/pts'
removing all entries of directory `dev/pts'
removing the directory itself `dev/pts'
removing all entries of directory `dev/pts'
removing the directory itself `dev/pts'
removing all entries of directory `dev/pts'
removing the directory itself `dev/pts'
removing all entries of directory `dev/pts'
removing the directory itself `dev/pts'

It's apparently having issues with removing the mount point of the devpts
filesystem.

:)
-Eric=20

--=20
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+eLW61LDXWFnqnE8RAvj9AJ4gXfLYh/NIZq5uhlB9P2LhjNCFYgCcC+sY
ceHO++dtyLwJzphF5D9ClcA=
=qxzk
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
