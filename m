Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310503AbSCLKzU>; Tue, 12 Mar 2002 05:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310515AbSCLKzK>; Tue, 12 Mar 2002 05:55:10 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:9736 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S310503AbSCLKzF>; Tue, 12 Mar 2002 05:55:05 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Linux 2.4.19-pre3
Date: 12 Mar 2002 10:35:35 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna8rmfn.46r.kraxel@bytesex.org>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1015929335 4353 127.0.0.1 (12 Mar 2002 10:35:35 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Here goes -pre3, with the new IDE code. It has been stable enough time in
>  the -ac tree, in my and Alan's opinion.

Doesn't boot my machine.  "Intel machine check architecture supported"
is the last message printed before it just hangs.

  Gerd

==============================[ cut here ]==============================
Linux version 2.4.19-pre3 (root@bogomips) (gcc version 2.95.3 20010315 (SuSE)) #2 Tue Mar 12 10:53:06 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
On node 0 totalpages: 262140
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32764 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=2.4.19-pre3 ro root=306 console=ttyS0,115200n8 console=tty0
Initializing CPU#0
Detected 451.028 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 897.84 BogoMIPS
Memory: 1033576k/1048560k available (784k kernel code, 14596k reserved, 275k data, 220k init, 131056k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
