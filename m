Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbTFMTAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265491AbTFMTAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:00:32 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13952 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S265490AbTFMTAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:00:30 -0400
Date: Fri, 13 Jun 2003 21:14:05 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21 released
Message-Id: <20030613211405.16faa9f6.us15@os.inf.tu-dresden.de>
In-Reply-To: <200306131453.h5DErX47015940@hera.kernel.org>
References: <200306131453.h5DErX47015940@hera.kernel.org>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.?Sh4O2GsXGpbgV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.?Sh4O2GsXGpbgV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2003 07:53:33 -0700 Marcelo Tosatti (MT) wrote:

MT> final:
MT> 
MT> - 2.4.21-rc8 was released as 2.4.21 with no changes.

Hi Marcelo,

I just tried 2.4.21. It reports -2412k data, which doesn't look right.

Regards,
-Udo.

Linux version 2.4.21 (root@Hell) (gcc version 3.3) #1 Fri Jun 13 21:06:00 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=805 parport=auto nmi_watchdog=2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 704.950 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1405.74 BogoMIPS
Memory: 774608k/786368k available (1939k kernel code, 11372k reserved, -2412k data, 284k init, 0k highmem)

--=.?Sh4O2GsXGpbgV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+6iJ9nhRzXSM7nSkRApVQAJ0X+nQy25BUAsdr6fw7ft2fknKfiACfXJcj
qJk/Pt4hxTujEC17mxaS9pk=
=wwFE
-----END PGP SIGNATURE-----

--=.?Sh4O2GsXGpbgV--
