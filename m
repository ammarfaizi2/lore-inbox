Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312703AbSCVPNR>; Fri, 22 Mar 2002 10:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSCVPNH>; Fri, 22 Mar 2002 10:13:07 -0500
Received: from whiterose.net ([64.65.220.94]:65290 "HELO whiterose.net")
	by vger.kernel.org with SMTP id <S312703AbSCVPMt>;
	Fri, 22 Mar 2002 10:12:49 -0500
Date: Fri, 22 Mar 2002 10:15:55 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: linux-kernel@vger.kernel.org
Subject: USB MSDOS driver for Hard drive to boot UMSDOS?
Message-ID: <Pine.BSF.4.21.0203221006210.20863-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a Dell optiplex GX1 333mhz with MSDOS 6.22 installed in one partion
with the rest being NT.  I also have UMSDOS in one of the hard drive
partitions. I would like to move the UMSDOS linux from the IDE/SCSI hard
drive to an external USB hard drive. After moving it to the external
drive, I want to boot the UMSDOS linux from the external USB hard drive.
However, since I don't have any USB drivers for either of the controllers
which seem to be *.sys the system doesn't know to create and assign a disk
drive letter to the attached external drive.

I know there is a company that makes "USB4DOS" at http://www.catc.com but
most of these companies are geared to embedded systems. Their price is
$1k US for this driver. I haven't been able to find any USB driver for
MSDOS that is free. Nor a driver that is generic enough to be used with
any USB device whether it be v1.1 and/or v2.0 USB in an intel system.

Is there any USB MSDOS drivers that I can use so that I can boot and run
linux off my external USB hard drive?


I realize a work around is to use a linux boot floppy and mount the other
filesystems via the Linux USB driver to access my UMSDOS linux
system. However, everytime I change the kernel it requires making another
linux boot disk. :(


Thanks for any info.


