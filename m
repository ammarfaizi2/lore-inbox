Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRGEJl2>; Thu, 5 Jul 2001 05:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGEJlS>; Thu, 5 Jul 2001 05:41:18 -0400
Received: from COD-ETH-14.WYOMING.COM ([204.227.211.254]:59637 "HELO
	noir.kain.org") by vger.kernel.org with SMTP id <S262168AbRGEJlH>;
	Thu, 5 Jul 2001 05:41:07 -0400
Date: Thu, 5 Jul 2001 03:41:13 -0600
From: Kain <kain@kain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Suitable Athlon Motherboard for Linux
Message-ID: <20010705034113.A24349@noir.kain.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200107041849.f64InoE12398@ambassador.mathewson.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200107041849.f64InoE12398@ambassador.mathewson.int>; from joe@mathewson.co.uk on Wed, Jul 04, 2001 at 07:49:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2001 at 07:49:50PM +0100, Joseph Mathewson wrote:
> Having heard the various horror stories about the VIA PCI data corruption
> bugs, and watching one Via based machine destroy itself with a Mandrake 8=
.0
>  2.4.3, I was just wondering if anyone had a suggestion for an Athlon
> motherboard that works reliably under Linux (I don't think all the issues
> have been cleared up in the kernel yet?).  There must be quite a few Linux
> Athlon users out there - what boards are you using and with what success?

I have had absolutely WONDERFUL luck with the Gigabyte GA-7DX and GA-7DXR b=
oards.  My setup is slightly high-end, but here's what I have:
(GA-7DX):
AMD Athlon TBird 1.33Ghz
256MB DDR SDRAM
Yamaha YMF744 Soundcard
CardXpert NVidia Geforce 2 MX (32MB)
some random bt848 videocapture card from Intel
Tekram DC390U3D Ultra3 SCSI
Matrox Networks Tulip (PNIC II Actually) NIC.

Works like a charm.  Here's the other machine:
(GA-7DXR):
TBird 1.33Ghz
No sound
Maxtrox Millenium G200 (I think... only used it in text mode)
1.25GB ECC DDR SDRAM
AMI Megaraid Elite 1600 Dual Ultra3 SCSI Raid.

The first machine is using a SuperMicro power supply (350 watts *sustained*=
 370 peak I think)
The second is using a random company dual 400W hotswap redundant PS.

All an all, I've had amazing luck with this hardware.  If you're looking at=
 it, give these a try.  YMMV.
--=20
I do not believe in the creed professed by the Jewish Church, by the Roman
Church, by the Greek Church, by the Turkish Church, by the Protestant Churc=
h,
nor by any Church that I know of.  My own mind is my own Church.
                -- Thomas Paine
**
Sadist
Bryon Roche, Kain <kain@kain.org>

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7RDY5BK2G/mh4q9URAutvAJ4rzNUCtbyCgPWpuFDlRMF/IoaEPACfcsmJ
rLIqA7fsXZfDSToXfQh/UbE=
=/qBj
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
