Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267223AbUIJIV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUIJIV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUIJIV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:21:26 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:26159 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267223AbUIJIVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:21:22 -0400
Message-ID: <66bd783004091001214f6a60a3@mail.gmail.com>
Date: Fri, 10 Sep 2004 15:21:18 +0700
From: Supphachoke Suntiwichaya <mrchoke@gmail.com>
Reply-To: Supphachoke Suntiwichaya <mrchoke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: LITE-ON COMBO SOHC-5232K
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use kernel 2.6.8.1 I can't write CD by LITE-ON COMBO SOHC-5232K
revision NK05, but I can write by revision NK0A.

remark I use cdrecord with root.

# cdrecord  dev=/dev/hdc -checkdrive
Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004
J๖rg Schilling
cdrecord: Warning: Running on Linux-2.6.8-4.tlcsmp
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
cdrecord: Warning: controller returns wrong size for CD capabilities page.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'LITE-ON '
Identifikation : 'COMBO SOHC-5232K'
Revision       : 'NK05'
Device seems to be: Generic CD-ROM.
cdrecord: Warning: controller returns wrong size for CD capabilities page.
cdrecord: Sorry, no CD/DVD-Recorder or unsupported CD/DVD-Recorder
found on this target.
cdrecord: Warning: controller returns wrong size for CD capabilities page.
Using generic SCSI-2       CD-ROM driver (scsi2_cd).
Driver flags   :
Supported modes:

# cdrecord  dev=/dev/hda -checkdrive
Cdrecord-Clone 2.01a38 (i686-pc-linux-gnu) Copyright (C) 1995-2004
J๖rg Schilling
cdrecord: Warning: Running on Linux-2.6.8-4.tlc
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
scsidev: '/dev/hda'
devname: '/dev/hda'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   :
Vendor_info    : 'LITE-ON '
Identifikation : 'COMBO SOHC-5232K'
Revision       : 'NK0A'
Device seems to be: Generic mmc2 DVD-ROM.
cdrecord: Found DVD media but DVD-R/DVD-RW support code is missing.
cdrecord: If you need DVD-R/DVD-RW support, ask the Author for cdrecord-ProDVD.
cdrecord: Free test versions and free keys for personal use are at
ftp://ftp.berlios.de/pub/cdrecord/ProDVD/
Using generic SCSI-3/mmc   CD/DVD driver (checks media) (mmc_cd_dvd).
Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R


-- 
===
MrChoke at G mail
