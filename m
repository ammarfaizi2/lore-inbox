Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSEPQLr>; Thu, 16 May 2002 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSEPQLq>; Thu, 16 May 2002 12:11:46 -0400
Received: from pD952CB1E.dip.t-dialin.net ([217.82.203.30]:25304 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S312962AbSEPQLp>; Thu, 16 May 2002 12:11:45 -0400
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Thu, 16 May 2002 18:11:37 +0200
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.15-ml3
Message-ID: <20020516161137.GA3015@madkiss.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linux 2.5.15-ml3 is available.=20

The Patch against vanilla 2.5.15 is available at
http://www.madkiss.org/kernel/2.5.15/ - please test and report bugs.

The following patches are applied in Linux 2.5.15-ml3:

   o remove duplicate CONFIG_SOUND_EMU10K1 (by Keith Owens <kaos@ocs.com.au=
>)
   o fix thread group exit problem (by Dave McCracken <dmccr@us.ibm.com>)
   o Fix BUG macro (by Rusty Russell <rusty@rustcorp.com.au>)
   o IDE 64 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o fix initrd breakage in (by James Bottomley <James.Bottomley@SteelEye.c=
om>)
   o rationalise copy_siginfo_to_user (by Stephen Rothwell <sfr@canb.auug.o=
rg.au>)
  =20
The following patches are applied in Linux 2.5.15-ml2:

   o IDE 61 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o IDE 62 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o IDE 63 (by Martin Dalecki <dalecki@evision-ventures.com>)
   o devfs v211 (by Richard Gooch <rgooch@atnf.csiro.au>)
   o rationalise asm-*/errno.h (by Stephen Rothwell <sfr@canb.auug.org.au>)
   o include asm/io.h in mm/bootmem.c (by Johan Adolfsson <johan.adolfsson@=
axis.com>)
   o Fix PPPoATM crash on disconnection (by Luca Barbieri <ldb@ldb.ods.org>=
)  =20
   o Fixing "offslab_limit /=3D" in mm/slab.c
   o vm86-Fixes (by Manfred Spraul <manfred@colorfullife.com>)

The following patches are applied in Linux  2.5.15-ml1:

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

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE849o4HPo+jNcUXjARAlM/AJ46ecrbM7EmerLo8tx0MemhXEEuvQCfXyOc
KXA6ty0eIu/L7oDelUdmqP8=
=CidM
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
