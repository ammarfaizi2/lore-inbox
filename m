Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSEOKph>; Wed, 15 May 2002 06:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316374AbSEOKpg>; Wed, 15 May 2002 06:45:36 -0400
Received: from pD952C091.dip.t-dialin.net ([217.82.192.145]:21452 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S316372AbSEOKpf>; Wed, 15 May 2002 06:45:35 -0400
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Wed, 15 May 2002 12:45:27 +0200
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.15-ml2
Message-ID: <20020515104527.GA864@madkiss.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linux 2.5.15-ml2 is available. It contains more bugfixes.

BTW: If you have patches you want to have included in -ml2, please don't
hestitate to contact me.

The following patches are applied in Linux 2.5.15-ml2:
  =20
   o IDE 61 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o IDE 62 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o IDE 63 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o devfs v211 (by Richard Gooch <rgooch@atnf.csiro.au>)
   o rationalise asm-*/errno.h (by Stephen Rothwell <sfr@canb.auug.org.au>)
   o include asm/io.h in mm/bootmem.c (by Johan Adolfsson <johan.adolfsson@=
axis.com>)
   o Fix PPPoATM crash on disconnection (by Luca Barbieri <ldb@ldb.ods.org>)
   o Fixing "offslab_limit /=3D" in mm/slab.c
   o vm86-Fixes (by Manfred Spraul <manfred@colorfullife.com>)

The following patches are applied in Linux 2.5.15-ml1:

   o Fix possible Oops in 3c509.c (by Kasper Dupont <kasperd@daimi.au.dk>)
   o IDE 60 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o iget_locked patches 1 to 6 (by Jan Harkes <jaharkes@cs.cmu.edu>)
   o ir253_smc_msg, ir253_long_set_bit and ir253_lsap_cache_fix
     patches (by Jean Tourrilhes <jt@bougret.hpl.hp.com>)
   o NTFS 2.0.7 release (by Anton Altaparmakov <aia21@cantab.net>)
   o remove unused variables from drivers/block/paride/pcd.c and
     drivers/block/paride/pd.c (by Frank Davis <fdavis@si.rr.com>)
   o Wireless ctitical fix (by Jean Tourrilhes <jt@bougret.hpl.hp.com>)
			      =20
--=20
*---------* -+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+-+
|  .''`.  | Martin Loschwitz ----------- hobbit.NeverAgain.DE |
| : :'  : + <madkiss@madkiss.org> ----- <madkiss@madkiss.de>  +
| `. `'`  + Viersen / Germany --- www: http://www.madkiss.de/ +
|   `-    | Use Debian GNU/Linux --- http://www.debian.org    |
*---------* -+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+-+

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE84jxHHPo+jNcUXjARApicAKCKP6Gvv6YUqMZFN0O5DCf5VxlDiwCfbpmx
BshJSAaJ8i47jtTSeBbLlBc=
=b6ba
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
