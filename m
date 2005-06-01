Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVFAX7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVFAX7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFAX5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:57:54 -0400
Received: from mail.tmr.com ([64.65.253.246]:64901 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261499AbVFAXtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:49:31 -0400
Message-ID: <429E4980.3020807@tmr.com>
Date: Wed, 01 Jun 2005 19:49:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com> <20050601204350.GM23621@csclub.uwaterloo.ca> <20050601205451.GR20782@holomorphy.com> <20050601210510.GL23488@csclub.uwaterloo.ca>
In-Reply-To: <20050601210510.GL23488@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:

>On Wed, Jun 01, 2005 at 01:54:51PM -0700, William Lee Irwin III wrote:
>  
>
>>Linux does not entail subscription to hardware upgrade treadmills. No
>>one should be forced by "peer pressure" or Linux deficiencies to buy
>>new hardware. And this is the single greatest thing about Linux ever.
>>    
>>
>
>Sure, I still use a 486 with linux for some jobs, but I am realistic
>about what I can expect from that level of hardware.
>
>  
>
>>O_LARGEFILE and current mmap() code will save him the cost of newer
>>hardware for the near term, and should he be particularly strapped for
>>cash later on when more than 16TB is needed, he knows to look at making
>>pgoff_t and/or swp_entry_t 64-bit on his own. There is no need for new
>>hardware, merely a choice between money and programming effort should
>>he break the 16TB barrier.
>>    
>>
>
>True, although I would think anyone doing actual work on that kind of
>data size would be using fairly new hardware anyhow.
>
>If you have to write all sorts of complex algorithms to work around a
>limitation in your current hardware, perhaps it is cheaper to buy newer
>hardware without that limitation.  Ofcourse if you are working on things
>in your spare time for free, then hardware upgrades are always the most
>expensive solution.
>

I suspect that the company would like to depreciate 30+ 4-way Xeon 
rackmount systems over a little longer than two years. The actual 
limiting factor is probably not money but getting the corporate 
configuration committee to go 64 bit...

Thanks for all the input.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

