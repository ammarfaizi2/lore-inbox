Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUA2QK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUA2QK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:10:26 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:18193 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266166AbUA2QKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:10:21 -0500
Message-ID: <40193136.4070607@techsource.com>
Date: Thu, 29 Jan 2004 11:13:42 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: chakkerz@optusnet.com.au
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
In-Reply-To: <200401291211.05461.chakkerz@optusnet.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Unger wrote:
>>No more being at the mercy of closed-development graphics chip designers
>>who make Linux an after-though if they even think of us at all.

> Oh ... don't get me wrong, i think that the conceptual idea is awesome. 
> Personally, i wouldn't know where to begin, but can the open source community 
> compete with Nvidia and ATI? afterall this goes beyond software, it delves 
> into hardware. Sure there are people with the knowledge, maybe even with the 
> means, but i doubt the financial backing would be there from the get go. 
> 

We cannot compete with Nvidia or ATI or 3Dlabs or Matrox or even S3.

The real question we have to ask ourselves is, what would be the market 
demand for a graphics card that is 3 generations behind the state of the 
art and over-priced, the only advantage being that it's a 100% open 
architecture?

I don't have $100k to have it fabricated, so we have to goad some 
company into doing it for us, and given the volumes, they'll have to 
charge way more than it's worth if you compare its capabilities against 
ATI et al.

I've got some great ideas for how to do this chip, but they're frankly 
nothing revolutionary.  The obvious test bed is an FPGA.  That imposes 
serious limitations on what kind of logic utilization and performance we 
can get.  The ASIC version can be clocked faster, but we dare not put in 
untested logic.  (And we can't afford the tools necessary to do the 
proper simulation.)


So, the big question:  How many units a year would be sold for an 
underpowered, over-priced graphics card that just happens to be 100% 
open and 100% supported?


