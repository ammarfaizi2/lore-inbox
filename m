Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTI3IJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbTI3IJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:09:25 -0400
Received: from law11-f60.law11.hotmail.com ([64.4.17.60]:60945 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261195AbTI3IJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:09:23 -0400
X-Originating-IP: [220.224.20.13]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: diegocg@teleline.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
Date: Tue, 30 Sep 2003 13:39:22 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F60EhrkMNYwoy0001cb7a@hotmail.com>
X-OriginalArrivalTime: 30 Sep 2003 08:09:22.0960 (UTC) FILETIME=[28376100:01C3872A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

your graphics card (hw) is resource that needs to be managed by OS.
leaving it to 3rd party developers is an *adhoc* solution, *a stark immoral 
choice*.
my friend gotta new AMD athlon with nvidia gforce 32mb shared memory,
but he is on the mercy of X people to get full support for it.
for now he has to do with generic i810 driver?
any answer for that.
my question is can't X be eleminated by providing support for
graphics drivers and other routines at kernel  level?



>From: Diego Calleja García <diegocg@teleline.es>
>To: "kartikey bhatt" <kartik_me@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Can't X be elemenated?
>Date: Mon, 29 Sep 2003 23:11:01 +0200
>
>El Mon, 29 Sep 2003 20:14:56 +0530 "kartikey bhatt" <kartik_me@hotmail.com> 
>escribió:
>
> > 1st. X is bloat. Though it's good for server environments. For desktop 
>pcs
> > it's too heavy. On my machine (PIII500 with 128MB RAM) I have to choose 
>from
> > either to run X or compile 2.6.0-test6.
> >
> > 2nd. It's process based client/server architecture is a bottleneck. It's 
>not
> > as interactive as is supposed to be.
>
>You might want to discuss that with X people. It's been demonstrated that 
>the
>client/server model is noy a bottleneck...in fact there're benchmarks which 
>show
>X being almost as fast as the windows GDI... (using the shared memory 
>extension)
>
> >
> > 3rd. Most important. I can't impress or convince my window(crash)(TM) 
>user
> > friends, relatives (who saw X running on my pc) to use Linux.
>
>I can impress them quite well running the X server in a different machine 
>:)
>
> >
> > 4th. I want to see desktop being ruled by Linux.
>
>It's already ruling my desktop 8)
>
>But you might want to talk with X developers. Linus it's just the kernel
>maintainer.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
MSN Hotmail now on your Mobile phone. 
http://server1.msn.co.in/sp03/mobilesms/ Click here.

