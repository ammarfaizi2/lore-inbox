Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVDUOrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVDUOrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDUOrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:47:09 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:45231 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261404AbVDUOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:47:04 -0400
Message-ID: <4267BC1C.1050801@kromtek.com>
Date: Thu, 21 Apr 2005 18:43:40 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Doug Ledford <dledford@redhat.com>, Dave Airlie <airlied@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: nVidia stuff again
References: <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no> <20050413125921.GN17865@csclub.uwaterloo.ca> <20050413130646.GF32354@marowsky-bree.de> <20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com> <425E77BB.5010902@aitel.hist.no> <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com> <21d7e997050420161234141e23@mail.gmail.com> <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com> <20050421133554.GU17865@csclub.uwaterloo.ca>
In-Reply-To: <20050421133554.GU17865@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, Apr 21, 2005 at 08:15:02AM -0400, Doug Ledford wrote:
> 
>>Ha!  That's the whole damn point Dave.  Use your head.  Just because ATI
>>is getting more complex with their GPU does *not* mean nVidia is.  Go
>>back to my original example of the aic7xxx cards.  The alternative to
>>their simple hardware design is something like the BusLogic or QLogic
>>cards that are far more complex.  Your assuming that because the ATI
>>cards are getting more complex and people are less able to discern their
>>makeup just by reading the specs that the nVidia cards are doing the
>>same, nVidia is telling you otherwise, and you are just blowing that off
>>as though you know more about their cards than they do.  Reality is that
>>they *could* be telling the truth and the fact that their card is a more
>>simplistic card than ATIs may be the very reason that ATI has ponied up
>>specs and they haven't.  Therefore, you can reliably discern absolutely
>>*zero* information about the nVidia cards from a reference to ATI specs.
> 
> 
> Certainly possible.  Maybe all their real IP is in the code, although if
> that was true, letting opensource peope ahve the programing spec and
> have to do their own drivers wouldn't expose that IP.  I have no idea.
> 

Even without opening up the code, but with programming specs there are 
many graphics driver guys out there, given the specs out it would not be 
too hard to have a decent driver, without the Nvidia IP. In that case 
there would be no question of IP violation.

Or maybe somebody can do a clean room implementation provided Nvidia 
agrees to some NDA, and the resultant work is acceptable to Nvidia 
provided that it is free of their IP.. Many hardware vendors do resort 
to these to get their hardware working properly under Linux, and in some 
cases, the Linux driver has proved to be a better driver than their 
Windows counterparts, albeit with lesser gimmicks/features.


Manu
