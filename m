Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUIXKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUIXKQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUIXKQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:16:49 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:24716 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268663AbUIXKQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:16:17 -0400
Message-ID: <4153F3C7.7050900@yahoo.com.au>
Date: Fri, 24 Sep 2004 20:15:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Rokos <michal@rokos.info>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
References: <20040924014643.484470b1.akpm@osdl.org> <4153EED2.1050508@yahoo.com.au> <200409241205.31735.michal@rokos.info>
In-Reply-To: <200409241205.31735.michal@rokos.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Rokos wrote:
> On Friday 24 of September 2004 11:54, Nick Piggin wrote:
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9
>>>-rc2/2.6.9-rc2-mm3/
>>>
>>>
>>>+natsemi-remove-compilation-warnings.patch
>>>
>>> natsemi.c warning fixes
>>
>>My card fails to work unless this change is backed out.
> 
> 
> Yeah - very true.
> 
> I didn't have time to find out why... The change looked very innocent.
> 
> Michal
> 
> PS: I warned about it yesterday.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109594207116846&w=4
> 
> 

That's OK, no harm done :)
