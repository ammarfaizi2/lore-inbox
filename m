Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbREBMEs>; Wed, 2 May 2001 08:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbREBME3>; Wed, 2 May 2001 08:04:29 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:31752 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S132825AbREBMEX>; Wed, 2 May 2001 08:04:23 -0400
Date: Wed, 2 May 2001 14:00:23 +0200
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS-performance drop with 2.4.4 and 8139too
Message-ID: <20010502140023.S16655@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010502115457.A6739@sonne.glowinginthesun>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010502115457.A6739@sonne.glowinginthesun>; from hvb@gmx.net on Wed, May 02, 2001 at 11:54:58AM +0200
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

did you already try the patch that Andrew Morton sent in the=20
"New rtl8139 driver prevents ssh from exiting." thread?

On Wed, May 02, 2001 at 11:54:58AM +0200, Hendrik Volker Brunn wrote:
> When upgrading from kernel 2.4.3 to 2.4.4 my=20
> NFS-performance drops badly.

> knfsd, linux-2.4.4, 8139too-0.9.16
> linux-2.4.4, 8139too-0.9.16
>=20
> transfers seem to start with about 2 MB/s but drop=20
> immediatly to about 20 K/s.

PS: If you send your .config, pipe it via grep -v "^#"

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67/bWxmLh6hyYd04RAq1JAKCasGee2hcKkbMEX+FEuF2GPJBfsgCgnD6W
Hp4hCgLr/BHC31KEbiRqFoA=
=AYTN
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--
