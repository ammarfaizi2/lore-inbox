Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSJXFrw>; Thu, 24 Oct 2002 01:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265322AbSJXFrw>; Thu, 24 Oct 2002 01:47:52 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:35597 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S265320AbSJXFrv>;
	Thu, 24 Oct 2002 01:47:51 -0400
Date: Thu, 24 Oct 2002 09:52:49 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Robin Johnson <robbat2@orbis-terrarum.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SGI Visual Support?
Message-ID: <20021024055249.GA303@pazke.ipt>
Mail-Followup-To: Robin Johnson <robbat2@orbis-terrarum.net>,
	linux-kernel@vger.kernel.org
References: <20021024001332.GA6151@cherenkov.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20021024001332.GA6151@cherenkov.orbis-terrarum.net>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2002 at 05:13:32PM -0700, Robin Johnson wrote:
> Greetings list
>=20
> I am writing to enquire of the status of SGI Visual Workstation support
> in the 2.5 series.

Non functional at this moment :(
=20
> The Linux VISWS page on sourceforge
> http://sourceforge.net/projects/linux-visws
> Has a patch for 2.5.24
> This currently doesn't apply 2.5.44 due to the i386 arch split in
> 2.5.37.
>=20
> It seems the patch on the site developed from this thread, but ends
> inconclusively:
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D102465834001728&w=3D2
>=20
> Did anybody get it working more than this?
> Does anybody have any more input about the VISWS code working/not
> working?

I'm working on it, but lack of time makes my progress very slow.

> I ask because I have a lot of VISWS 320 boxes at my disposal now and I
> am interested in using them because of the really nice SCSI system they
> have.  I've got one connected to a 20Gb DLT drive for doing backups
> presently, running 2.2.10 (the only kernel I could get to work). But I
> need a more recent kernal with netfilter for some firewalling issues.

Are you ready to test new kernels ?=20
I'm interested in dual cpu VISWS because mine has 1 cpu and it's=20
impossible(?) to buy a VRM in Russia.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9t4qxBm4rlNOo3YgRAvxCAJ46CG/2UqLk4Bt5XY+YEv/XQWBfbQCePNSV
8rC83nf1G/tKWeW/MC/eOY8=
=0PsM
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
