Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133039AbRDRGjr>; Wed, 18 Apr 2001 02:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRDRGjh>; Wed, 18 Apr 2001 02:39:37 -0400
Received: from [202.54.102.148] ([202.54.102.148]:30581 "EHLO
	Ngate.in.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S133039AbRDRGjb>; Wed, 18 Apr 2001 02:39:31 -0400
Date: Wed, 18 Apr 2001 12:01:32 +0530 (IST)
From: NARENDRA L JOSHI <narendra.joshi@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: boot failure with kernel 2.4.2. please help.
Message-ID: <Pine.LNX.4.04.10104181148580.9702-100000@seepzmail.in.tatainfotech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have kernel 2.2.16 installed on my machine and trying to upgrade to
2.4.2. Verified from 2.4.2 Documentation that I have different utilities
(gcc, binutils, pppd etc) of the specified or the greater version.
I am able to make bzImage for 2.4.2, but when I try to boot with
2.4.2 option in lilo, the message is :
Uncompressing the kernel.... Ok. Booting the kernel


and the machine hangs !

The configuration is mostly default (except for SCSI not needed, so 
made off, soundcard off, USB off).
On getting few hints from mailing list discussions, I did make sure that
processor type is set correctly (and not default pentium-2/3) in .config
file and also tried changing '-oformat' option to '--oformat' in Makefile.
But still the machine fails to boot with 2.4.2

I am new to kernel area.
Requesting all of you hints for diagnosing / correcting the problem.

thanx & regards,
Narendra Joshi


