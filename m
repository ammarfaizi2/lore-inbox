Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129729AbQK3Mp7>; Thu, 30 Nov 2000 07:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129636AbQK3Mpu>; Thu, 30 Nov 2000 07:45:50 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:19979 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S129436AbQK3Mpd>; Thu, 30 Nov 2000 07:45:33 -0500
Date: Thu, 30 Nov 2000 13:12:37 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
Message-ID: <20001130131237.F7894@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Andre Hedrick <andre@linux-ide.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001129225210.A10380@bastion.sprileet.net> <Pine.LNX.4.10.10011292210320.1035-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011292210320.1035-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Nov 29, 2000 at 10:25:45PM -0800
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On Wed, Nov 29, 2000 at 10:25:45PM -0800, Andre Hedrick wrote:
> If you want to run it under PIO mode and not do DMAing then it will work.
> Also it goes for any device that does ATAPI DMA and not ATA DMA.
> There is a difference!

Could you work out this a little bit to make ot more clear?
What's the difference between ATAPI DMA and ATA DMA?
Is this a controller(chipset) or a device thing?
What controllers or devices are affected?
Is this only a problem for mixing such things on the same bus? The same
controller?

It boils down to one question:
What do the users have to avoid?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6JkQ0xmLh6hyYd04RAvjuAJ95OKme8ACDxubYrLC5J5h31htKeACbBVMV
NQgq8mMtYF7In7BdSH3bs0o=
=j7Sh
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
