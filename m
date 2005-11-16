Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVKPSc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVKPSc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbVKPSc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:32:58 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:8442 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030426AbVKPSc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:32:57 -0500
Message-ID: <437B7B45.5070104@mvista.com>
Date: Wed, 16 Nov 2005 10:32:37 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Alex Williamson <alex.williamson@hp.com>, rmk+serial@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts (take 2)
References: <1132158489.5457.10.camel@tdi> <437B6C9C.3060307@mvista.com> <Pine.LNX.4.58.0511160939180.23982@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511160939180.23982@shark.he.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 16 Nov 2005, George Anzinger wrote:
> 
> 
>>Could you _please_ not put inline patches after the signature mark ("-- ").  In my mailer (mozilla)
>>this causes the patch to be greyed out and, more importantly, NOT included in a reply.  This, in
>>turn, makes it hard to comment on details in the patch.
> 
> 
> 
> Would it help if Alex used the documented canonical patch format,
> using "---" instead of "-- "?  I sorta doubt it.

I suspect it would.  The "-- \n" is a documented signature mark (took 
me a while to find this out) and I have found no way to make mozilla 
do anything different with it.  I don't have any documentation on 
"---" but it surly is not a signature mark and I suspect most mailers 
will not attach any signifigance to it.


> 
> BTW, George, please hit Return/Enter around column 70+...

Sorry, some how my wrap line length moved up to 100.  Fixed now.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
