Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281997AbRKUXow>; Wed, 21 Nov 2001 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282001AbRKUXom>; Wed, 21 Nov 2001 18:44:42 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:61445 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281997AbRKUXo1>;
	Wed, 21 Nov 2001 18:44:27 -0500
Message-Id: <5.1.0.14.0.20011122104119.026ebdc0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 22 Nov 2001 10:44:23 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
Cc: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
In-Reply-To: <Pine.GSO.4.33.0111211116130.795-100000@gurney>
In-Reply-To: <E166VOz-0004kH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:19 AM 21/11/01 +0000, Alastair Stevens wrote:
> > > CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+".
> > > CPU1 is instead labelled just "AMD Athlon(tm) Processor".
> >
> > Those strings are read directly out of the CPU.
>
>Hmmm, case of a suspicious CPU then? I haven't physically looked at it,
>but all the correct XP flags (such as "sse") are reported, so it must be
>the real thing.
>
>Perhaps one is a certified MP processor, and the other (ahem) isn't...?

Tried swapping the processors around?

If it's processor dependent, that'll show it. If it's code, it'll be the same.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

