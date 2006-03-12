Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWCLDZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWCLDZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 22:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWCLDZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 22:25:25 -0500
Received: from pool-68-237-228-215.ny325.east.verizon.net ([68.237.228.215]:60883
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S1751240AbWCLDZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 22:25:24 -0500
Subject: Re: Linux v2.6.16-rc6
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uPn+CJiVcPTsKvhjthAA"
Date: Sat, 11 Mar 2006 22:25:33 -0500
Message-Id: <1142133933.19645.0.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 Dropline GNOME 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uPn+CJiVcPTsKvhjthAA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Are these UDMA transfer rates normal?

libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00: 07.0[A] -> Link [APSI] -> GSI 22 (level, low)
-> IRQ 20
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 20
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 20
ata1: SATA link down (SStatus 0)
scsi1 : sata_nv
ata2: SATA link down (SStatus 0)
scsi2 : sata_nv
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -=
=3D
>
IRQ 21
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
eth0: link up.
ata3: SATA link up 1.5 Gbps (SStatus 113)
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091065c55]
ata3: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3068 86:3c01 87:4003
88:203f
ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata3: dev 0 configured for UDMA/100
scsi3 : sata_nv
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800004f6359]
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3468 86:3c41 87:4003
88:407f
ata4: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata4: dev 0 configured for UDMA/133
scsi4 : sata_nv
  Vendor: ATA       Model: WDC WD2000JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdb1 sdb2 sdb3 sdb4
sd 3:0:0:0: Attached scsi disk sdb
  Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc:<4>nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
 sdc1 sdc2 sdc3 sdc4
sd 4:0:0:0: Attached scsi disk sdc

Cheers!

Paul B.

--=-uPn+CJiVcPTsKvhjthAA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEE5Stwu5Nmh3PsiMRArKLAJ45HhxqatCj/+6H0lQv+0MRH8KDyQCdHv01
SpgIqa97Q4Z31qSofY6ZR0Q=
=rUvc
-----END PGP SIGNATURE-----

--=-uPn+CJiVcPTsKvhjthAA--

