Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSEKToZ>; Sat, 11 May 2002 15:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316268AbSEKToY>; Sat, 11 May 2002 15:44:24 -0400
Received: from p50858F56.dip.t-dialin.net ([80.133.143.86]:4553 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S314686AbSEKToX>; Sat, 11 May 2002 15:44:23 -0400
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Sat, 11 May 2002 21:44:16 +0200
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.15-ml1
Message-ID: <20020511194416.GA651@madkiss.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I made a little patchset for Linux Kernel 2.5.15 which contains some new
things and some bugfixes.

The Patch against vanilla 2.5.15 is available at
http://www.madkiss.org/kernel/2.5.15/ - please test and report bugs.

The following patches are applied in Linux 2.5.15-ml1:

   o Fix possible Oops in 3c509.c (by Kasper Dupont <kasperd@daimi.au.dk>)
   o IDE 60 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o iget_locked patches 1 to 6 (by Jan Harkes <jaharkes@cs.cmu.edu>)
   o ir253_smc_msg, ir253_long_set_bit and ir253_lsap_cache_fix patches=20
     (by Jean Tourrilhes <jt@bougret.hpl.hp.com>)
   o NTFS 2.0.7 release (by Anton Altaparmakov <aia21@cantab.net>)
   o remove unused variables from drivers/block/paride/pcd.c and
     drivers/block/paride/pd.c (by Frank Davis <fdavis@si.rr.com>)
   o Wireless ctitical fix (by Jean Tourrilhes <jt@bougret.hpl.hp.com>)

--=20
*---------* -+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+-+
|  .''`.  | Martin Loschwitz ----------- hobbit.NeverAgain.DE |
| : :'  : + <madkiss@madkiss.org> ----- <madkiss@madkiss.de>  +
| `. `'`  + Viersen / Germany --- www: http://www.madkiss.de/ +
|   `-    | Use Debian GNU/Linux --- http://www.debian.org    |
*---------* -+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+--+-+-+

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE83XSQHPo+jNcUXjARAlDsAKC8UN/s00swHcZ1yDP1euqCzUtp3ACglTep
6pmWTTdW5W0HMw2zswQar8g=
=s2kJ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
