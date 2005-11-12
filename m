Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVKLV5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVKLV5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVKLV5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:57:40 -0500
Received: from mout0.freenet.de ([194.97.50.131]:34280 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S964799AbVKLV5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:57:40 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Linuv 2.6.15-rc1
Date: Sat, 12 Nov 2005 22:57:05 +0100
User-Agent: KMail/1.8.3
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de> <20051112215304.GB21448@stusta.de>
In-Reply-To: <20051112215304.GB21448@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1267883.nDEaAvpfZ1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511122257.05552.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1267883.nDEaAvpfZ1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 22:53, you wrote:
> >   CHK     include/linux/version.h
> >   CHK     include/linux/compile.h
> >   CHK     usr/initramfs_list
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/powerpc/kernel/built-in.o: In function `platform_init':
> > : undefined reference to `prep_init'
> > arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference t=
o `ucSystemType'
> > arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference t=
o `_prep_type'
> > make: *** [.tmp_vmlinux1] Error 1
>=20
> Please send your .config .


I did this in my first mail:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D113182883102937&q=3Dp5

=2D-=20
Greetings Michael.

--nextPart1267883.nDEaAvpfZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdmUxlb09HEdWDKgRAk1yAJ9Zw1PylO0oCkhLNjODh840edv1QgCfaPkj
elXJPo3dLwfaAJtoCmXyWSk=
=WJF4
-----END PGP SIGNATURE-----

--nextPart1267883.nDEaAvpfZ1--
