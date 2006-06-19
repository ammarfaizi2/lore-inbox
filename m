Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWFSAFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWFSAFW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWFSAFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:05:22 -0400
Received: from iucha.net ([209.98.146.184]:29880 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S1750762AbWFSAFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:05:21 -0400
Date: Sun, 18 Jun 2006 19:05:20 -0500
To: linux-usb-users@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Microsoft Wireless 6000 Mouse/Keyboard
Message-ID: <20060619000520.GR7905@iucha.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mX5f3I2XfUAeTwiv"
Content-Disposition: inline
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.11+cvs20060403
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mX5f3I2XfUAeTwiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is the Microsoft Wireless Desktop 6000 supported under Linux? I am
plugging the dongle into the motherboard port and under Linux 2.6.17 I
cannot see it, but get the following error messages in the log:

[  149.386325] usb 2-7: new low speed USB device using ohci_hcd and address=
 6
[  149.469949] usb 2-7: device descriptor read/64, error -110
[  149.600844] usb 2-7: device descriptor read/64, error -110
[  149.728097] usb 2-7: new low speed USB device using ohci_hcd and address=
 7
[  149.811719] usb 2-7: device descriptor read/64, error -110
[  149.942610] usb 2-7: device descriptor read/64, error -110
[  150.069866] usb 2-7: new low speed USB device using ohci_hcd and address=
 8
[  150.258930] usb 2-7: device not accepting address 8, error -110
[  150.338920] usb 2-7: new low speed USB device using ohci_hcd and address=
 9
[  150.527982] usb 2-7: device not accepting address 9, error -110
[  275.993109] usb 2-8: new low speed USB device using ohci_hcd and address=
 10
[  276.076735] usb 2-8: device descriptor read/64, error -110
[  276.207624] usb 2-8: device descriptor read/64, error -110
[  276.334880] usb 2-8: new low speed USB device using ohci_hcd and address=
 11
[  276.418503] usb 2-8: device descriptor read/64, error -110
[  276.549394] usb 2-8: device descriptor read/64, error -110
[  276.676650] usb 2-8: new low speed USB device using ohci_hcd and address=
 12
[  276.862082] usb 2-8: device not accepting address 12, error -110
[  276.942069] usb 2-8: new low speed USB device using ohci_hcd and address=
 13
[  277.127496] usb 2-8: device not accepting address 13, error -110
[  373.348645] usb 2-7: new low speed USB device using ohci_hcd and address=
 14
[  373.534074] usb 2-7: device not accepting address 14, error -110
[  373.614062] usb 2-7: new low speed USB device using ohci_hcd and address=
 15
[  373.799490] usb 2-7: device not accepting address 15, error -110
[  373.879484] usb 2-7: new low speed USB device using ohci_hcd and address=
 16
[  373.961286] usb 2-7: device descriptor read/64, error -110
[  374.090359] usb 2-7: device descriptor read/64, error -110
[  374.217615] usb 2-7: new low speed USB device using ohci_hcd and address=
 17
[  374.299421] usb 2-7: device descriptor read/64, error -110
[  374.428495] usb 2-7: device descriptor read/64, error -110

This is on a Asus A8N-SLI motheboard using Nforce4 chipset. I have plugged =
it
into a Laptop using the Intel BX chipset, but I wasn't getting even these
errors. Nothing at all.

The OS is debian testing/unstable . Is there anything I can do to help debug
this problem?

Thank you,
florin

--=20
If we wish to count lines of code, we should not regard them as lines
produced but as lines spent.                       -- Edsger Dijkstra

--mX5f3I2XfUAeTwiv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFElepAND0rFCN2b1sRApZdAJ9LtD/+KlyRAOVPVVqi/nYFYbh6rwCgqPMZ
MOxmYxVe/e2NOJOCjjHDYGY=
=lyf0
-----END PGP SIGNATURE-----

--mX5f3I2XfUAeTwiv--
