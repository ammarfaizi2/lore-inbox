Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129295AbQKUVi4>; Tue, 21 Nov 2000 16:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbQKUVis>; Tue, 21 Nov 2000 16:38:48 -0500
Received: from [209.143.110.29] ([209.143.110.29]:15113 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129295AbQKUVi1>; Tue, 21 Nov 2000 16:38:27 -0500
Message-ID: <3A1AE442.E8C83873@the-rileys.net>
Date: Tue, 21 Nov 2000 16:08:26 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <200011202032.eAKKWQi06469@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> So what? My former machine ran fine with Win95/WinNT. Linux wouldn't even
> end booting the kernel. Reason: P/100 was running at 120Mhz. Fixed that, no
> trouble for years. Not the only case of WinXX running (apparently?) fine
> on broken/misconfigured hardware I've seen, mind you.

This is something I've noticed as well...

Windoze is not the only OS to handle bad hardware better than Linux.  On
my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
causing random bus-type errors in Linux.  Same as when I accidentally
(long story) overclocked the bus on the CPU.  I think that more
tolerance for faulty hardware (more than just poorly programmed BIOS or
chipsets with known bugs) is something that might be worth looking into.
 I'm sure it would solve problems like this (which I clearly identify as
a hardware problem, because the same thing happened with the bad DIMM,
the overclocked bus, and two different overclocked processors (AMD 5x86
and AMD K6-2 500) and went away when I remedied the offending problem). 
Additionally, overclockers (I myself am a reformed one) might appreciate
more tolerance for such things.

My two cents/pence/centavos/local tiny currency denomination,
	David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
