Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130387AbQKUVuw>; Tue, 21 Nov 2000 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131060AbQKUVul>; Tue, 21 Nov 2000 16:50:41 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:63412 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S130387AbQKUVua>; Tue, 21 Nov 2000 16:50:30 -0500
From: David Lang <david.lang@digitalinsight.com>
To: David Riley <oscar@the-rileys.net>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2000 14:04:34 -0800 (PST)
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <3A1AE442.E8C83873@the-rileys.net>
Message-ID: <Pine.LNX.4.21.0011211400380.2031-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, usually when it turns out that Linux finds hardware problems the
underlying cause is that linux makes more effective use of the component,
and as such something that was marginal under windows fails under linux as
the correct timing is used.

David Lang

 On Tue, 21 Nov 2000, David Riley wrote:

> Date: Tue, 21 Nov 2000 16:08:26 -0500
> From: David Riley <oscar@the-rileys.net>
> To: unlisted-recipients:  ;
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Defective Red Hat Distribution poorly represents Linux
> 
> Horst von Brand wrote:
> > 
> > So what? My former machine ran fine with Win95/WinNT. Linux wouldn't even
> > end booting the kernel. Reason: P/100 was running at 120Mhz. Fixed that, no
> > trouble for years. Not the only case of WinXX running (apparently?) fine
> > on broken/misconfigured hardware I've seen, mind you.
> 
> This is something I've noticed as well...
> 
> Windoze is not the only OS to handle bad hardware better than Linux.  On
> my Mac, I had a bad DIMM that worked fine on the MacOS side, but kept
> causing random bus-type errors in Linux.  Same as when I accidentally
> (long story) overclocked the bus on the CPU.  I think that more
> tolerance for faulty hardware (more than just poorly programmed BIOS or
> chipsets with known bugs) is something that might be worth looking into.
>  I'm sure it would solve problems like this (which I clearly identify as
> a hardware problem, because the same thing happened with the bad DIMM,
> the overclocked bus, and two different overclocked processors (AMD 5x86
> and AMD K6-2 500) and went away when I remedied the offending problem). 
> Additionally, overclockers (I myself am a reformed one) might appreciate
> more tolerance for such things.
> 
> My two cents/pence/centavos/local tiny currency denomination,
> 	David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
