Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWEVL1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWEVL1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWEVL1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:27:03 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:11139 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750757AbWEVL1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:27:01 -0400
Message-ID: <44719F4C.6090508@aitel.hist.no>
Date: Mon, 22 May 2006 13:23:56 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?IkTDtmhyLCBNYXJrdXMgSUNDLUgi?= 
	<Markus.Doehr@siegenia-aubi.com>
CC: "'Peter Gordon'" <codergeek42@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <FC7F4950D2B3B845901C3CE3A1CA6766012A9E71@mxnd200-9.si-aubi.siegenia-aubi.com>
In-Reply-To: <FC7F4950D2B3B845901C3CE3A1CA6766012A9E71@mxnd200-9.si-aubi.siegenia-aubi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Döhr, Markus ICC-H wrote:

>[...]
>  
>
>>>Did you actually do that? Starting Firefox over a 6 Mbit VPN takes 
>>>about 3 minutes on a FAST machine. That´s not acceptable - our users 
>>>want (almost) immediate response to an application, to clicking and 
>>>waiting 10 seconds until the app is doing something.
>>> 
>>>
>>>      
>>>
>>It is not that bad.  I tried starting firefox on a machine 
>>20km away, using a 5Mbps ADSL link from the "wrong" end.  (I 
>>ssh'ed into my home pc from work.) Firefox started in 55s, 
>>not 3min. Still bad, but that is a firefox problem, not a 
>>generic X-tunneling problem.  I can start the lyx word 
>>processor in 3s over the same link, and have decent 
>>performance while using it too.
>>    
>>
>
>55 seconds to start an application... That´s not acceptable. Why do you
>think it´s a Firefox problem? Did you try this with a Java application? 
>  
>
I say it is a firefox problem because other apps don't have this delay!
So clearly, firefox is doing something stupid here that other apps
doesn't do.  Waiting 3 seconds isn't that painful.

I haven't tried with a java app - I don't think I have any of those.
Are they special in any way?

>I don´t wanna blame X in general, just saying it is useless if you´re
>sitting in Hungary or Poland and want to work remotely - in comparision to
>M$´s  RDP. 
>  
>
It all depends on what latency and bandwith you have.
5-6 Mbps is enough to have a decent experience, except for
some stupid apps.  Firefox is certainly slow in starting, and
somewhat slow later too.  But one doesn't have to run firefox,
there are other browsers.  And usually, the webbrowser is
something you _can_ run locally.  At least if you're simply
trying to read webpages.

>The question for me is not "X or not X" - but how to enable people to start
>e. g. "sam" on an HP-UX box without needing to wait minutes before the
>application starts. It works - for sure, but the speed is for our needs not
>acceptable. Additionally ~ 60 ssh sessions on a single box will but a lot of
>CPU load on the system beside the fact, that you need a BIG BIG pipe.
>  
>
60 sessions - sure.  The more users, the more resources you need .  .  .

Helge Hafting
