Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbTCIOIx>; Sun, 9 Mar 2003 09:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbTCIOIx>; Sun, 9 Mar 2003 09:08:53 -0500
Received: from diale022.ppp.lrz-muenchen.de ([129.187.28.22]:37042 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262512AbTCIOIv>; Sun, 9 Mar 2003 09:08:51 -0500
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
From: Daniel Egger <degger@fhm.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <m1adg4kbjn.fsf@frodo.biederman.org>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	 <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
	 <20030307233916.Q17492@flint.arm.linux.org.uk>
	 <m1d6l2lih9.fsf@frodo.biederman.org>
	 <20030308100359.A27153@flint.arm.linux.org.uk>
	 <m18yvpluw7.fsf@frodo.biederman.org>
	 <20030308161309.B1896@flint.arm.linux.org.uk>
	 <m1vfytkbsk.fsf@frodo.biederman.org> <1047209545.4102.3.camel@sonja>
	 <m1adg4kbjn.fsf@frodo.biederman.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gSVoDYotkMf+24yQWFOP"
Organization: 
Message-Id: <1047219550.4102.6.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Mar 2003 15:19:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gSVoDYotkMf+24yQWFOP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Son, 2003-03-09 um 12.46 schrieb Eric W. Biederman:

> I use etherboot.  It is small and has not problems acting as network
> bootstrap program if you are stuck with EFI.

Sorry for being unclear here; I'm neither using IA64 nor EFI. This is
plain etherboot resp. PXE/etherboot on ia32.

> Etherboot can load to any address < 4GB and can jump to a 32bit entry
> point.  It's not rocket science or magic just good open source code.

Maybe etherboot isn't the culprit here, but mknbi won't let me
create bigger tagged boot kernels.

--=20
Servus,
       Daniel

--=-gSVoDYotkMf+24yQWFOP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+a01dchlzsq9KoIYRAv5oAKDgx2BEnCWtHSSwpPv77bqY6svhCgCgtnTT
mGFktcpgugUPqwbZma+92H8=
=LfgO
-----END PGP SIGNATURE-----

--=-gSVoDYotkMf+24yQWFOP--

