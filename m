Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSLWBJQ>; Sun, 22 Dec 2002 20:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSLWBJQ>; Sun, 22 Dec 2002 20:09:16 -0500
Received: from [209.195.52.121] ([209.195.52.121]:50609 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S265355AbSLWBJP>; Sun, 22 Dec 2002 20:09:15 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Robert Love <rml@tech9.net>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Sun, 22 Dec 2002 17:05:20 -0800 (PST)
Subject: Re: [BENCHMARK] scheduler tunables with contest - starvation_limit
In-Reply-To: <1040605610.2127.3.camel@icbm>
Message-ID: <Pine.LNX.4.44.0212221703070.10806-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

one other thing that would be interesting to test on the osdl machines
would be the effect of different filesystems.

the origional set of tests were all done on reiserfs, it would be
interesting to see if there is a difference between it and the others.

David Lang

On 22 Dec 2002, Robert Love wrote:

> Date: 22 Dec 2002 20:06:51 -0500
> From: Robert Love <rml@tech9.net>
> To: Con Kolivas <conman@kolivas.net>
> Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
> Subject: Re: [BENCHMARK] scheduler tunables with contest -
>     starvation_limit
>
> On Thu, 2002-12-19 at 18:48, Con Kolivas wrote:
>
> > osdl, contest, tunable - starvation limit on 2.5.52-mm1
>
> Con, curiously, what is this OSDL hardware like?
>
> One thing I always liked about your Contest runs were you did them on
> your home machine, which was presumably fairly run-of-the-mill so we
> could keep an eye on the low-end desktop machines.
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
