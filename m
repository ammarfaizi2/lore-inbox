Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270266AbRH1GdF>; Tue, 28 Aug 2001 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270269AbRH1Gc4>; Tue, 28 Aug 2001 02:32:56 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:63654 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S270266AbRH1Gcr>; Tue, 28 Aug 2001 02:32:47 -0400
Date: Tue, 28 Aug 2001 01:32:40 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: USB UHCI broken again w/ visor
Message-ID: <20010828013239.N16752@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvAn5G4Ewe70kJ1i"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LvAn5G4Ewe70kJ1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

USB verbose debug is ON, using driver usb-uhci, on an alpha, kernel
2.4.9, new batteries in the thing.  This worked with 2.4.7.  What
happened?  It seems like every other kernel version it gets broken
again, and I can't sync my visor.

Aug 28 01:08:53 draal kernel: usb-uhci.c: $Revision: 1.259 $ time 12:40:16 =
Aug 25 2001=20
Aug 28 01:08:53 draal kernel: usb-uhci.c: High bandwidth mode enabled=20
Aug 28 01:08:53 draal kernel: usb-uhci.c: USB UHCI at I/O 0x8080, IRQ 18=20
Aug 28 01:08:53 draal kernel: usb-uhci.c: Detected 2 ports=20
Aug 28 01:08:53 draal kernel: usb.c: new USB bus registered, assigned bus n=
umber 1=20
Aug 28 01:08:53 draal kernel: usb.c: kmalloc IF fffffc000fbef0a0, numif 1=
=20
Aug 28 01:08:53 draal kernel: usb.c: new device strings: Mfr=3D0, Product=
=3D2, SerialNumber=3D1=20
Aug 28 01:08:53 draal kernel: usb.c: USB device number 1 default language I=
D 0x0=20
Aug 28 01:08:53 draal kernel: Product: USB UHCI Root Hub=20
Aug 28 01:08:53 draal kernel: SerialNumber: 8080=20
Aug 28 01:08:53 draal kernel: hub.c: USB hub found=20
Aug 28 01:08:53 draal kernel: hub.c: 2 ports detected=20
Aug 28 01:08:53 draal kernel: hub.c: standalone hub=20
Aug 28 01:08:53 draal kernel: hub.c: ganged power switching=20
Aug 28 01:08:53 draal kernel: hub.c: global over-current protection=20
Aug 28 01:08:53 draal kernel: hub.c: power on to power good time: 2ms=20
Aug 28 01:08:53 draal kernel: hub.c: hub controller current requirement: 0m=
A=20
Aug 28 01:08:53 draal kernel: hub.c: port removable status: RR=20
Aug 28 01:08:53 draal kernel: hub.c: local power source is good=20
Aug 28 01:08:53 draal kernel: hub.c: no over-current condition exists=20
Aug 28 01:08:53 draal kernel: hub.c: enabling power on all ports=20
Aug 28 01:08:53 draal kernel: usb.c: hub driver claimed interface fffffc000=
fbef0a0=20
Aug 28 01:08:53 draal kernel: usb-uhci.c: v1.251:USB Universal Host Control=
ler Interface driver=20
Aug 28 01:08:53 draal kernel: hub.c: port 1 connection change=20
Aug 28 01:08:53 draal kernel: hub.c: port 1, portstatus 100, change 3, 12 M=
b/s=20
Aug 28 01:08:53 draal kernel: hub.c: port 2 connection change=20
Aug 28 01:08:53 draal kernel: hub.c: port 2, portstatus 100, change 3, 12 M=
b/s=20
Aug 28 01:08:53 draal kernel: hub.c: port 1 enable change, status 100=20
Aug 28 01:08:53 draal kernel: hub.c: port 2 enable change, status 100=20
Aug 28 01:09:01 draal kernel: hub.c: port 1 connection change=20
Aug 28 01:09:01 draal kernel: hub.c: port 1, portstatus 101, change 1, 12 M=
b/s=20
Aug 28 01:09:01 draal kernel: hub.c: port 1, portstatus 103, change 0, 12 M=
b/s=20
Aug 28 01:09:01 draal kernel: hub.c: USB new device connect on bus1/1, assi=
gned device number 2=20
Aug 28 01:09:04 draal kernel: usb_control/bulk_msg: timeout=20
Aug 28 01:09:04 draal kernel: usb.c: USB device not accepting new address=
=3D2 (error=3D-60)=20
Aug 28 01:09:04 draal kernel: hub.c: port 1, portstatus 103, change 0, 12 M=
b/s=20
Aug 28 01:09:04 draal kernel: hub.c: USB new device connect on bus1/1, assi=
gned device number 3=20
Aug 28 01:09:07 draal kernel: usb_control/bulk_msg: timeout=20
Aug 28 01:09:07 draal kernel: usb.c: USB device not accepting new address=
=3D3 (error=3D-60)=20
Aug 28 01:09:34 draal kernel: hub.c: port 1 connection change=20
Aug 28 01:09:34 draal kernel: hub.c: port 1, portstatus 100, change 3, 12 M=
b/s=20
Aug 28 01:09:34 draal kernel: hub.c: port 1 enable change, status 100=20
Aug 28 01:15:22 draal kernel: hub.c: port 1 connection change=20
Aug 28 01:15:22 draal kernel: hub.c: port 1, portstatus 101, change 1, 12 M=
b/s=20
Aug 28 01:15:22 draal kernel: hub.c: port 1, portstatus 103, change 0, 12 M=
b/s=20
Aug 28 01:15:22 draal kernel: hub.c: USB new device connect on bus1/1, assi=
gned device number 4=20
Aug 28 01:15:25 draal kernel: usb_control/bulk_msg: timeout=20

Please cc me as I am not on this list.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--LvAn5G4Ewe70kJ1i
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuLOwcACgkQjwioWRGe9K30PwCgixbiqCOZd+baUdqC8FuY5Mle
YDMAnjmbDot5WIwAteUtf9ZM8Ii9VQQp
=dEWq
-----END PGP SIGNATURE-----

--LvAn5G4Ewe70kJ1i--
