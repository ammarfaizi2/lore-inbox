Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSCDSjH>; Mon, 4 Mar 2002 13:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292674AbSCDSiY>; Mon, 4 Mar 2002 13:38:24 -0500
Received: from mother.ludd.luth.se ([130.240.16.3]:49092 "EHLO
	mother.ludd.luth.se") by vger.kernel.org with ESMTP
	id <S292669AbSCDShq>; Mon, 4 Mar 2002 13:37:46 -0500
Date: Mon, 4 Mar 2002 19:37:44 +0100 (MET)
From: texas <texas@ludd.luth.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Dual P4 Xeon i860 system - lockups in 2.4 & no boot in 2.2
In-Reply-To: <E16glTg-0003Nd-00@the-village.bc.nu>
Message-ID: <Pine.GSU.4.33.0203041935260.437-100000@father.ludd.luth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, it's been a few days now since installing Kernel 2.2 with "noapic"
added to lilo append and the server does seem stable. That probably means
there's something wrong in 2.4 that are causing the lockups. I'm no kernel
guru and have no idea what it could be but will be running 2.2 until I
hear about others being able to run 2.4 stable on dual P4 Xeon systems
with the i860 chipset. It's rather new hardware and I assume the lockups
could be caused by lack of support for it in the kernel...? Or maybe not,
since 2.2 works well and it's even older.

It's sad not being able to run 2.4 as I seem to loose a lot of
performance. The load average on this database server is now 4 or higher
while it was 3 or lower when I ran 2.4. Hyperthreading might be part of
the reason for the performance improvement and that's a feature I'd really
like to be able to use. Note that I tried running 2.4 with HT turned off
in both kernel and BIOS and the server still locked on me so HT should not
be the cause of the stability problems.

If this might be a kernel issue in 2.4 and you need more info to debug it,
just ask me for any stats you might need, I'd be glad to supply it. If you
think it's a BIOS problem, should I contact Supermicro and let them know
about this?

Thanks,
Johan

