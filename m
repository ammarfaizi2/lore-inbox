Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKDBDT>; Fri, 3 Nov 2000 20:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132213AbQKDBC7>; Fri, 3 Nov 2000 20:02:59 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:37761 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S129066AbQKDBCs>; Fri, 3 Nov 2000 20:02:48 -0500
From: davej@suse.de
Date: Sat, 4 Nov 2000 01:02:41 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
Message-ID: <Pine.LNX.4.21.0011040101090.6163-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote...
>> I believe the MII always has CPUID enabled. It was the older Cyrixes
>> that did not. DaveJ is the guru..
> Well, according to comments in bugs.h, some broken BIOSes disable cpuid.

That bug fix is for the earlier Cyrix 6x86 if I'm not mistaken.
The MII is a different monster.

d.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
