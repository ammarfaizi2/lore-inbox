Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbRERL3D>; Fri, 18 May 2001 07:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262294AbRERL2y>; Fri, 18 May 2001 07:28:54 -0400
Received: from ulima.unil.ch ([130.223.144.143]:39953 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S262293AbRERL2i>;
	Fri, 18 May 2001 07:28:38 -0400
Date: Fri, 18 May 2001 13:28:33 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10: Oops
Message-ID: <20010518132833.C16486@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010517225232.A8072@ulima.unil.ch> <E150VWd-0006Cz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E150VWd-0006Cz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 17, 2001 at 10:41:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Alan Cox (alan@lxorguk.ukuu.org.uk):

> > SCSI subsystem driver Revision: 1.00
> > PCI: Found IRQ 11 for device 00:0b.0
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
0000
> > printing eip:
>=20
> What scsi drivers do you have and which are on IRQ 11

I have two:
00:0b.0 SCSI storage controller: Future Domain Corp. TMC-18C30 [36C70]
        Flags: medium devsel, IRQ 11
        I/O ports at b400 [size=3D16]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
        Subsystem: Adaptec 2940U2W SCSI Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        BIST result: 00
        I/O ports at d000 [disabled] [size=3D256]
        Memory at df800000 (64-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: <available only to root>

Thanks,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BQdhFDWhsRXSKa0RAsKUAJ95eX6pUNHESYN84KqzFJ1tkQBPEQCeMqLP
o5bGUP1+9KDEHl1kwp69rog=
=9aAi
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
