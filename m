Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131206AbRDBUxi>; Mon, 2 Apr 2001 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRDBUx2>; Mon, 2 Apr 2001 16:53:28 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:18976 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131206AbRDBUxU>; Mon, 2 Apr 2001 16:53:20 -0400
Message-ID: <3AC8E633.9070503@humboldt.co.uk>
Date: Mon, 02 Apr 2001 21:50:59 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010112
X-Accept-Language: en
MIME-Version: 1.0
To: "Richard A. Smith" <rsmith@bitworks.com>
CC: "andre@linux-ide.org" <andre@linux-ide.org>,
   Padraig Brady <Padraig@AnteFacto.com>,
   "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   Steffen Grunewald <steffen@gfz-potsdam.de>
Subject: Re: Cool Road Runner (was CFA as Ide.)
In-Reply-To: <MDAEMON-F200104021529.AA291937MD92027@bitworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard A. Smith wrote:


> IIRC SanDisk was the original people to come out with IDE CFA and everyone else just copied 
> them.  I have the SanDisk datasheets that I can send you if you need them to verify stuff.  I 
> believe that if you verify it with the SanDisk then all the other MFG's should work as well.

If only. In my limited experience SanDisk cards have been the most 
tolerant. I suspect that Sandisk actually implement the full range of 
timings documented in the spec, and nobody else bothers.

This isn't normally a problem on PC hardware, but if you try to 
implement an interface to talk to a CF card in an embedded system you 
find this out.

- Adrian Cox

