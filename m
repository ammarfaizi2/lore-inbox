Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAJVfb>; Wed, 10 Jan 2001 16:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAJVfV>; Wed, 10 Jan 2001 16:35:21 -0500
Received: from thomson.uni2.net ([195.82.195.104]:24330 "EHLO thomson.uni2.net")
	by vger.kernel.org with ESMTP id <S129610AbRAJVfJ>;
	Wed, 10 Jan 2001 16:35:09 -0500
Date: Wed, 10 Jan 2001 22:29:11 +0100 (CET)
From: "Tom G. Christensen" <tom.christensen@get2net.dk>
To: Robert Kaiser <rob@sysgo.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
In-Reply-To: <Pine.LNX.4.21.0101101640460.20028-100000@dagobert.svc.sysgo.de>
Message-ID: <Pine.LNX.4.30.0101102119550.7069-100000@atlantis.tgcnet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Robert Kaiser wrote:

> In the meantime, it would be helpful if anyone who has successfully
> booted a 2.4.0 kernel on a 386 could report this to the list.
>
I had no problems booting an AMD 386DX/40 with 32 megs of RAM.
I just dumped a bzImage (703K) to a floppy and it booted on that just
fine.
Kernel was built using egcs-1.1.2 from RH 6.2

If I build the same kernel on a RH7 system using gcc 2.96 (gcc-2.96-69)
the machine reboots after "Uncompressing Linux... Ok, boot the kernel" no
more text is printed.

.config is available on request.

-tgc

-- 
Tom G. Christensen, Denmark <tom.christensen@get2net.dk>
Homepage: http://hjem.get2net.dk/tgc
Linux 2.2.16-3 on an i586



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
