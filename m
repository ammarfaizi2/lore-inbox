Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbRCKMnt>; Sun, 11 Mar 2001 07:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131415AbRCKMnj>; Sun, 11 Mar 2001 07:43:39 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:35596 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S131413AbRCKMnT>; Sun, 11 Mar 2001 07:43:19 -0500
Date: Sun, 11 Mar 2001 15:40:56 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: ivor@linuxqa.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_id's
Message-ID: <20010311154056.A32503@debian>
In-Reply-To: <3AAB60DF.95DEA707@Linuxqa.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
User-Agent: Mutt/1.0.1i
In-Reply-To: <3AAB60DF.95DEA707@Linuxqa.com>; from ivor@il.linuxqa.com on Sun, Mar 11, 2001 at 01:26:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 11, 2001 at 01:26:23PM +0200, ivor wrote:
> Hi
>=20
> Please could someone help me id the following host and pci bridges, they
> don't appear in kernel 2.4.0.
>=20

Where these strange numbers come from ?
Only guesses after this line:

> Host Bridge
> PCI_0600_1106_0000_3050_0000_30-0-0

1106 - VIA Technologies, Inc.
3050 - VIA ACPI controller.

> PCI_0600_8086_1043_1130_8028_02-0-0

?

> PCI_0600_8086_1028_2500_0095_03-0-0

8086 - Intel Corporation.
2500 - 82820 820 (Camino) Chipset Host Bridge (MCH).

> PCI Bridge
> PCI_0604_1106_1106_8391_0000_00-0-0

8391 - VT8371 [KX133 AGP]

> PCI_0604_8086_0000_1131_0000_02-0-0

?

> PCI_0604_8086_0000_244e_0000_01-0-0

244e - 82820 820 (Camino 2) Chipset PCI.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--DocE+STaALJfprDB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6q3JYBm4rlNOo3YgRAiZBAJ0ZFOsJGnA/vu98zchCSOpLhtlZMQCeMUMO
4cAi/kWtJSit+v0I8NcR9FM=
=FTnY
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
