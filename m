Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTAJIEw>; Fri, 10 Jan 2003 03:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbTAJIEv>; Fri, 10 Jan 2003 03:04:51 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4320
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S264001AbTAJIEu>; Fri, 10 Jan 2003 03:04:50 -0500
Date: Fri, 10 Jan 2003 00:12:42 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: nForce IDE in 2.5?
Message-ID: <20030110081242.GA1750@kamui>
References: <20030110073530.GA6681@kamui>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20030110073530.GA6681@kamui>
User-Agent: Mutt/1.4i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bleh, ignore me. I just read the archives

-Josh

On Thu, Jan 09, 2003 at 11:35:30PM -0800, Joshua M. Kwan wrote:
> It's missing a PCI identifier variable for the chipset itself, and if I=
=20
> knew what its value is supposed to be, or where to put it, I would make=
=20
> a patch for it.. =3D\
>=20
> Attached is the error log from the build. I am using 2.5.x-current...
>=20
> Regards
> Josh

> In file included from drivers/ide/pci/nvidia.c:29:
> drivers/ide/pci/nvidia.h:35: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclared=
 here (not in a function)
> drivers/ide/pci/nvidia.h:35: initializer element is not constant
> drivers/ide/pci/nvidia.h:35: (near initialization for `nvidia_chipsets[0]=
.device')
> drivers/ide/pci/nvidia.h:43: initializer element is not constant
> drivers/ide/pci/nvidia.h:43: (near initialization for `nvidia_chipsets[0]=
.enablebits[0]')
> drivers/ide/pci/nvidia.h:43: initializer element is not constant
> drivers/ide/pci/nvidia.h:43: (near initialization for `nvidia_chipsets[0]=
.enablebits[1]')
> drivers/ide/pci/nvidia.h:43: initializer element is not constant
> drivers/ide/pci/nvidia.h:43: (near initialization for `nvidia_chipsets[0]=
.enablebits')
> drivers/ide/pci/nvidia.h:46: initializer element is not constant
> drivers/ide/pci/nvidia.h:46: (near initialization for `nvidia_chipsets[0]=
')
> drivers/ide/pci/nvidia.c: In function `nforce_ratemask':
> drivers/ide/pci/nvidia.c:79: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclared=
 (first use in this function)
> drivers/ide/pci/nvidia.c:79: (Each undeclared identifier is reported only=
 once
> drivers/ide/pci/nvidia.c:79: for each function it appears in.)
> drivers/ide/pci/nvidia.c: In function `ata66_nforce':
> drivers/ide/pci/nvidia.c:288: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclare=
d (first use in this function)
> drivers/ide/pci/nvidia.c: In function `nforce_init_one':
> drivers/ide/pci/nvidia.c:338: warning: `_MOD_INC_USE_COUNT' is deprecated=
 (declared at include/linux/module.h:419)
> drivers/ide/pci/nvidia.c: At top level:
> drivers/ide/pci/nvidia.c:343: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclare=
d here (not in a function)
> drivers/ide/pci/nvidia.c:343: initializer element is not constant
> drivers/ide/pci/nvidia.c:343: (near initialization for `nforce_pci_tbl[0]=
.device')
> drivers/ide/pci/nvidia.c:343: initializer element is not constant
> drivers/ide/pci/nvidia.c:343: (near initialization for `nforce_pci_tbl[0]=
')
> drivers/ide/pci/nvidia.c:344: initializer element is not constant
> drivers/ide/pci/nvidia.c:344: (near initialization for `nforce_pci_tbl[1]=
')
> make[3]: *** [drivers/ide/pci/nvidia.o] Error 1
> make[2]: *** [drivers/ide/pci] Error 2
> make[1]: *** [drivers/ide] Error 2
> make: *** [drivers] Error 2




--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HoB66TRUxq22Mx4RAnvRAJ9r1LphkwGL/Y1VGV0lVbHG0VmuuACglopA
DDIkukqDiT6TSutYlASOQCE=
=VFQn
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
