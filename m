Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUJWRHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUJWRHf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUJWRHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:07:34 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:8613 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S261245AbUJWRHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:07:25 -0400
Message-ID: <417A8EC2.7070505@keyaccess.nl>
Date: Sat, 23 Oct 2004 19:02:58 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Puetz <puetzk@puetzk.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <41785D8D.5070808@keyaccess.nl> <clcqrr$u5o$1@sea.gmane.org>
In-Reply-To: <clcqrr$u5o$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Puetz wrote:

> Rene Herman wrote:
> 
>>I'd actually prefer AMD, but the AMD market isn't offfering a solution
>>comparable to Intel's integrated video. That means AMD and VIA and the
>>like are loosing (some, mine at least :-) money since they don't have a
>>graphics solution comparable to Intel, in terms of openness and
>>basicness. I believe really only nForce and (to a degree; I hardly see
>>it) ATI IGP are available in the AMD motherboard market. If you could
>>produce something as good or better as Intel's, you might want to go
>>talk to VIA, or AMD directly, and have them license it from you and
>>massproduce it into their chipsets.
> 
> 
> Well, there are the via k8m800 chipsets.

I see, must say I hadn't seen it before. Have basically stopped paying 
attention to VIA some time ago but read lately (mostly on this list, I 
believe) that they were actually getting better at opening up some 
things. When I just now checked, I see there's still not a datasheet in 
sight though. As far as I can see best I can hope for is that VIA would 
consider me "an appropriate open source developer" which, considering 
that I will not be developing for many things I still like to read the 
datasheets for, seems unlikely. But more to the point, even if it were 
likely, the competition here is developer.intel.com, not $RANDOMCORP's 
discretion.

 From this, VIA seems a bit better than nVidia (if only because it would 
be hard to be worse) and comparable to ATI's developer program. Since I 
see that all the rest of their chipsets is equally undocumented, at 
least publicly, for me personally this means I will not be buying their 
products.

> That's (I believe?) a unichrome2 IGP, which should have opensource
> DRI support via unichrome.sf.net (caveat - I have a unichrome1 in an
> epia M1000, not the athlon64 variant). It's no hot-rod performer, but
> it's good enough for tuxracer and neverball. I have no idea how it
> really compares performance-wise to the intel stuff, but it does at
> least have open drivers and reasonable GL acceleration.

I see from unichrome.sf.net that they are piecing together register info 
from drivers they got VIA to release...

Okay, so talking to VIA was a bad idea. AMD is good with documentation 
(looking at printed copies of the AMD 751/756 datasheets as we speak) 
but haven't been too interested in chipsets upto now. They generally do 
one or a few and lay off when VIA gets upto speed. Not having anything 
basic and open available _is_ driving some customers to Intel though, so 
maybe they're still interested in it for a basic chipset, with VIA for 
the gadget-add market.

Rene.
