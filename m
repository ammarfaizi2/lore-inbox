Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbULHJRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbULHJRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbULHJRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:17:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:56454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261157AbULHJQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:16:52 -0500
X-Authenticated: #3340650
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB
	Devices do not work
From: Florian Krammel <florian_kr@gmx.de>
To: Kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <1102452729.7531.29.camel@orange-bud>
References: <1102333735.5095.4.camel@orange-bud>
	 <1102339694.13485.26.camel@localhost.localdomain>
	 <1102450409.7531.10.camel@orange-bud> <1102452729.7531.29.camel@orange-bud>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TeK/GrsYEk9EMNHZ4bai"
Date: Wed, 08 Dec 2004 10:15:57 +0100
Message-Id: <1102497357.15817.2.camel@orange-bud>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TeK/GrsYEk9EMNHZ4bai
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

ok I think "lspci" tell me the Chipset?

everything is from ATI

[root@orange-bud dev]# lspci
00:00.0 Host bridge: ATI Technologies Inc: Unknown device 7833
00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 7838
00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4367 (rev
01)
00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4368 (rev
01)
00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4365 (rev
01)
00:14.0 SMBus: ATI Technologies Inc: Unknown device 4363 (rev 03)
00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4369 (rev
01)
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 436c (rev 01)
00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4362 (rev 01)
00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown
device 4361(rev 03)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon 9100 PRO
IGP
02:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
02:07.0 Communication controller: Agere Systems (former Lucent
Microelectronics) V.92 56K WinModem (rev 03)
[root@orange-bud dev]#            =20

--=-TeK/GrsYEk9EMNHZ4bai
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBtsZMm9XQAcbR/eIRAuVBAJ9SZ7POFCMaSijdoppCc9YMuyFY/wCdEYWo
8B3GlbfkSVB/xp6YLP4FcRU=
=AOVU
-----END PGP SIGNATURE-----

--=-TeK/GrsYEk9EMNHZ4bai--

