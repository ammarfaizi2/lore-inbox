Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVIAPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVIAPep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVIAPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:34:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:56535 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030206AbVIAPeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:34:44 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1
Date: Thu, 1 Sep 2005 17:38:38 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org>
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1538208.Zr0KNTN1S5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509011738.45821.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1538208.Zr0KNTN1S5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 01 September 2005 12:55, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.=
13
>-mm1/

When I switch on my external harddisk, which is connected through usb, the=
=20
kernel hangs. First time I did that at bootup there were a lot of backtrace=
s=20
printed on the screen but they did not find the way in the logfile :/
Now I switched the drive on while running and everything freezes after thos=
e=20
messages:

usb 1-2.2: new high speed USB device using ehci_hcd and address 3
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
  Vendor: ST325082  Model: 3A                Rev: 3.02
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: assuming drive cache: write through
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: assuming drive cache: write through

dominik

--nextPart1538208.Zr0KNTN1S5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQxcghQvcoSHvsHMnAQI5ygQAh0wYbI7cjT6VbrJ8ajuCR7xT19aUHD9/
dHT81Pf94zVMas8/sVPn6GXobUfI+T63nHef7kA6lR2bgJYo2EWudvSV9ScLUf2G
6s27MB5Znrt/GIPqThJJmSQ5LhWplNY8k2rRk25Q1TklUEgU79OUWGaNVfoUhzyO
v/Nb339Rh6k=
=q1Aa
-----END PGP SIGNATURE-----

--nextPart1538208.Zr0KNTN1S5--
