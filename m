Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSJZAwM>; Fri, 25 Oct 2002 20:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJZAwM>; Fri, 25 Oct 2002 20:52:12 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:64150 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261746AbSJZAwM> convert rfc822-to-8bit; Fri, 25 Oct 2002 20:52:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: jim.houston@ccur.com, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Date: Fri, 25 Oct 2002 14:58:21 -0500
User-Agent: KMail/1.4.3
References: <3DB88F6D.F408FF06@ccur.com>
In-Reply-To: <3DB88F6D.F408FF06@ccur.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210251458.21284.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 October 2002 19:25, Jim Houston wrote:
> Hi Rob,
>
> The Posix timers entry in your list is confused.  I don't know how
> my patch got the name Google.

Sorry, misread "George's version" as "Google's version" at 5 am one morning.
Lot of late nights recently... :)

> I think Dan Kegel misunderstood George's answer to my previous
> announcement.  George might be picking up some of my changes, but there
> will still be two patches for Linus to choose from.  You included the URL to 
> George's answer which quoted my patch, rather than the URL I sent you.

Had it in, then took it out.  I'm trying to collate down the list wherever I 
can.

> Here is the URL for an archived copy of my latest patch:
>      Jim Houston's  [PATCH] alternate Posix timer patch3
>      http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000027416&w=2

It's back now.

> I would be happy to see either version go into 2.5.

So what exactly is the difference between them?

> The URLs for George's patches are incomplete.  I believe this is the
> most recent (it's from Oct 18).  The Sourceforge.net reference has the
> user space library and test programs, but I did not see 2.5 kernel
> patches.
>
>   [PATCH ] POSIX clocks & timers take 3 (NOT HIGH RES)
>      http://marc.theaimsgroup.com/?l=linux-kernel&m=103489669622397&w=2

He's up to version 4 now.

> Thanks
> Jim Houston - Concurrent Computer Corp.

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
