Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270796AbRHNUMX>; Tue, 14 Aug 2001 16:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270797AbRHNUMO>; Tue, 14 Aug 2001 16:12:14 -0400
Received: from mta2n.bluewin.ch ([195.186.1.211]:59012 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S270796AbRHNUMK>;
	Tue, 14 Aug 2001 16:12:10 -0400
Message-ID: <3B790F670002119D@mta2n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per@computer.org>
To: "David Ford" <david@blue-labs.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 14 Aug 2001 22:20:41 +0200
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Are we going too fast?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001 15:54:33 -0400, David Ford wrote:

>Per Jessen wrote:
>
>>>On Mon, 13 Aug 2001 14:11:32 +0100 (BST), Alan Cox wrote:
>>>
>>>If you want maximum stability you want to be running 2.2 or even 2.0. Newer
>>>less tested code is always less table. 2.4 wont be as stable as 2.2 for a
>>>year yet.
>>>
>>
>>Couldn't have put that any better. On mission-critical systems, this is
>>exactly what people do. Personally, my experience is from the big-iron
>>world of S390 -  if you're a bleeding-edge organisation, you'll be out
>>there applying the latest PTFs, you'll be running the latest OS/390 etc. 
>>If you're conservative, you're at least 2, maybe 3 releases (in todays 
>>OS390 this means about 18-24 months) behind. If you're ultra-conservative,
>>you'll wait for the point where you can no longer avoid an upgrade.
>>
>
>Unfortunately, this methodology also introduces another important 
>factor.  You are the most likely target for exploits and 
>vulnerabilities.  As is ever so strongly evidenced by the great numbers 
>of people being exploited because the version of software they have is 
>outdated.
>
>It's a gross measure of risks; where does the risk come from, how can it 
>affect you, and what can you do about it.

Completely agree. This is also why most big-iron shops employ a couple
of people to do change-management, AKA risk-management. And of course
they'll try to evaluate the risk in moving to the latest OS390 and/or Linux  
versus possible external threats. In the OS390 world, external threats
are limited, and being conservative often pays off very well. In the
Linux world, lots of systems have tight internet connections, and being
alert and uptodate will pay off. It all depends - there is no cure for all.


/Per

PS: is it customary to copy posters on a posting to lkml ? I don't
mind, but just to avoid flames.

regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


