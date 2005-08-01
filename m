Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVHAR4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVHAR4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 13:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVHAR4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 13:56:32 -0400
Received: from mx3.mail.ru ([194.67.23.149]:46121 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S261321AbVHAR4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 13:56:31 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: cpufreq on Toshiba Portege 4000?
Date: Mon, 1 Aug 2005 21:56:17 +0400
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5795647.O5IBBJG9Lb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508012156.18271.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5795647.O5IBBJG9Lb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Toshiba documentation claims it supports speedstep technology. It has Ali=20
chipset and PIII CPU:

{pts/1}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev =
01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link=20
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
=2E..
{pts/1}% cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 747.738
cache size      : 256 KB
=2E..

Any cnahce to use cpufreq (or compatible) technique here?

TIA

=2Dandrey

--nextPart5795647.O5IBBJG9Lb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC7mJCR6LMutpd94wRAn4KAJ4gWqn9S8+NV4nf6WRj1o9QOlG1lACfRNkL
Mf83bfo3N0ME0DRjJGXmK4o=
=4k9S
-----END PGP SIGNATURE-----

--nextPart5795647.O5IBBJG9Lb--
