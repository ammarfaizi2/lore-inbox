Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbTEJKMF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTEJKMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:12:05 -0400
Received: from ulima.unil.ch ([130.223.144.143]:59822 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S263755AbTEJKMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:12:03 -0400
Date: Sat, 10 May 2003 12:24:39 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: 2.5.69 still can't write DVD...
Message-ID: <20030510102439.GA14982@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just wanted to inform you that the DVD writing in last 2.5 still don't
work :-(

Cdrecord-ProDVD-Clone 2.01a11 (i586-pc-linux-gnu) Copyright (C) 1995-2003 Jörg Schilling
Unlocked features: ProDVD Clone 
Limited  features: speed 
This copy of cdrecord is licensed for: private/research/educational_non-commercial_use
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'SONY    '
Identifikation : 'DVD RW DRU-500A '
Revision       : '2.0e'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Profile: DVD+R 
Profile: DVD+RW 
Profile: DVD-RW sequential overwrite 
Profile: DVD-RW restricted overwrite 
Profile: DVD-R sequential recording (current)
Profile: DVD-ROM 
Profile: CD-RW 
Profile: CD-R 
Profile: CD-ROM 
Using generic SCSI-3/mmc-2 DVD-R/DVD-RW driver (mmc_dvd).
Driver flags   : DVD MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96R RAW/R96R
Drive buf size : 4718592 = 4608 KB
FIFO size      : 67108864 = 65536 KB
Track 01: data  2137 MB        
Total size:     2137 MB = 1094395 sectors
Current Secsize: 2048
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 1204101
Starting to write CD/DVD at speed 1 in dummy TAO mode for single session.
Last chance to quit, starting dummy write in 9 seconds.  0.46% done, estimate finish Sat May 10 12:25:02 2003
  0.91% done, estimate finish Sat May 10 12:23:13 2003
  1.37% done, estimate finish Sat May 10 12:22:36 2003
  1.83% done, estimate finish Sat May 10 12:22:18 2003
  2.29% done, estimate finish Sat May 10 12:22:07 2003
  2.74% done, estimate finish Sat May 10 12:22:00 2003
   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is ON.
Starting new track at sector: 0
Track 01:    4 of 2137 MB written (fifo  99%) [buf  92%]  15.9x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 08 B8 00 00 1F 00
status: 0x1 (GOOD STATUS)
resid: 63488
cmd finished after 0.008s timeout 100s

write track data: error after 4571136 bytes
cdrecord-prodvd: A write error occured.
cdrecord-prodvd: Please properly read the error message above.
cdrecord-prodvd: Success. test unit ready: scsi sendcmd: no error
CDB:  00 00 00 00 00 00
status: 0x1 (GOOD STATUS)
cmd finished after 0.004s timeout 100s
Writing  time:    5.266s
Average write speed 309.2x.
Fixating...
Fixating time:   77.101s
cdrecord-prodvd: fifo had 1095 puts and 73 gets.
cdrecord-prodvd: fifo was 0 times empty and 11 times full, min fill was 99%.

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
