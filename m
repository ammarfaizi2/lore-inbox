Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbRE0TqY>; Sun, 27 May 2001 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbRE0TqP>; Sun, 27 May 2001 15:46:15 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:46040 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261791AbRE0TqG>; Sun, 27 May 2001 15:46:06 -0400
Date: Sun, 27 May 2001 12:45:59 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: Overkeen CDROM disk-change messages
To: linux-kernel@vger.kernel.org
Message-id: <200105271945.f4RJjxh00759@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL3]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It looks like my CDROM driver had a busy night last night
... ;-). This was with Linux 2.4.5, dual Pentium III, devfs, < 1GB
memory. There was no CDROM in the drive, but I had kept the CD player
running anyway.

Cheers,
Chris

May 27 02:10:03 twopit kernel: hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
May 27 02:10:03 twopit kernel: Uniform CD-ROM driver Revision: 3.12
May 27 02:10:03 twopit kernel: VFS: Disk change detected on device ide1(22,0)
May 27 02:10:35 twopit last message repeated 8 times
May 27 02:11:35 twopit last message repeated 15 times
May 27 02:12:35 twopit last message repeated 15 times
May 27 02:13:35 twopit last message repeated 15 times
May 27 02:14:35 twopit last message repeated 15 times
May 27 02:15:35 twopit last message repeated 15 times
May 27 02:16:35 twopit last message repeated 15 times
May 27 02:17:36 twopit last message repeated 15 times
May 27 02:18:32 twopit last message repeated 14 times
May 27 02:19:32 twopit last message repeated 15 times
May 27 02:20:32 twopit last message repeated 15 times
May 27 02:21:32 twopit last message repeated 15 times
May 27 02:22:32 twopit last message repeated 15 times
May 27 02:23:32 twopit last message repeated 15 times
May 27 02:24:33 twopit last message repeated 15 times
May 27 02:25:33 twopit last message repeated 15 times
May 27 02:26:33 twopit last message repeated 15 times
May 27 02:27:33 twopit last message repeated 15 times
May 27 02:28:33 twopit last message repeated 15 times
May 27 02:29:33 twopit last message repeated 15 times
May 27 02:30:34 twopit last message repeated 15 times
May 27 02:31:34 twopit last message repeated 15 times
May 27 02:32:34 twopit last message repeated 15 times
May 27 02:33:34 twopit last message repeated 15 times
...
[snip]
...
May 27 12:23:32 twopit last message repeated 15 times
May 27 12:24:33 twopit last message repeated 15 times
May 27 12:25:33 twopit last message repeated 15 times
May 27 12:26:33 twopit last message repeated 15 times
May 27 12:27:33 twopit last message repeated 15 times
May 27 12:28:33 twopit last message repeated 15 times
May 27 12:29:33 twopit last message repeated 15 times
May 27 12:30:33 twopit last message repeated 15 times
May 27 12:31:34 twopit last message repeated 15 times
May 27 12:32:34 twopit last message repeated 15 times
May 27 12:33:34 twopit last message repeated 15 times
May 27 12:33:58 twopit last message repeated 6 times

