Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRDBVwA>; Mon, 2 Apr 2001 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131362AbRDBVvu>; Mon, 2 Apr 2001 17:51:50 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:27405 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131352AbRDBVvn>; Mon, 2 Apr 2001 17:51:43 -0400
Message-ID: <3AC8F437.2000601@humboldt.co.uk>
Date: Mon, 02 Apr 2001 22:50:47 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010112
X-Accept-Language: en
MIME-Version: 1.0
To: "Richard A. Smith" <rsmith@bitworks.com>
CC: "andre@linux-ide.org" <andre@linux-ide.org>,
   "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   Padraig Brady <Padraig@AnteFacto.com>,
   Steffen Grunewald <steffen@gfz-potsdam.de>
Subject: Re: Cool Road Runner (was CFA as Ide.)
In-Reply-To: <MDAEMON-F200104021623.AA231904MD92067@bitworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard A. Smith wrote:

> On Mon, 02 Apr 2001 21:50:59 +0100, Adrian Cox wrote:
>> If only. In my limited experience SanDisk cards have been the most 
>> tolerant. I suspect that Sandisk actually implement the full range of 
>> timings documented in the spec, and nobody else bothers.
[...]

> We do actually use SST (Silcon Storage Technolog) CF's as well and they seem to function just 
> identical to the SanDisk but not quite as robust... I have had several of the SST's develope 
> a problem in the partition table and as thus the just error when you try to mount them.
> Several people on the liunx-embedded list also have similar experiences.
> 
> That seems to follow your observations...
> 
> Will it be worth while for you if I break out the scope and examine how our CF's handle the 
> PDIAG signal or can we just go on faith that they do indeed work as expected?

Might be interesting to see. The worst trouble I've had has been with 
noname parts from high street computer stores, and I don't know who the 
original manufacturer was. If I knew what subset of functionality 
digital cameras used I'd know what could be relied on.

- Adrian

