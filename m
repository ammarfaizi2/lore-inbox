Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSJYRwk>; Fri, 25 Oct 2002 13:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSJYRwk>; Fri, 25 Oct 2002 13:52:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28668 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261515AbSJYRwj>;
	Fri, 25 Oct 2002 13:52:39 -0400
Message-ID: <3DB98642.7649FF6@mvista.com>
Date: Fri, 25 Oct 2002 10:58:26 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim.houston@ccur.com
CC: landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
References: <3DB88F6D.F408FF06@ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> 
> Hi Rob,
> 
> The Posix timers entry in your list is confused.  I don't know how
> my patch got the name Google.
> 
> I think Dan Kegel misunderstood George's answer to my previous announcement.  George might be picking up some of my changes, but
> there will still be two
> patches for Linus to choose from.  You included the URL to George's answer
> which quoted my patch, rather than the URL I sent you.
> 
> Here is the URL for an archived copy of my latest patch:
>      Jim Houston's  [PATCH] alternate Posix timer patch3
>      http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000027416&w=2
> 
> I would be happy to see either version go into 2.5.
> 
> The URLs for George's patches are incomplete.  I believe this is the
> most recent (it's from Oct 18).  The Sourceforge.net reference has the
> user space library and test programs, but I did not see 2.5 kernel
> patches.
> 
>   [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
>      http://marc.theaimsgroup.com/?l=linux-kernel&m=103489669622397&w=2

I would be very careful picking up patches from the
digests.  Some of them have message size limits that cause
truncated patches.  I know mine was on the marc digest.  I
will post the latest HRT patches on the project sourceforge
site.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
