Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVCAJDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVCAJDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVCAJDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:03:43 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:17508 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261413AbVCAJDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:03:39 -0500
Message-ID: <42242FE8.6030904@yahoo.com.au>
Date: Tue, 01 Mar 2005 20:03:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] timestamp fixes
References: <42235517.5070504@us.ibm.com> <42235EC6.9030900@us.ibm.com> <4224232F.3000600@yahoo.com.au>
In-Reply-To: <4224232F.3000600@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrew Theurer wrote:
> 
>> Nick, can you describe the system you run the DB tests on?  Do you 
>> have any cpu idle time stats and hopefully some context switch rate 
>> stats?
> 
> 
> Yeah, it is dbt3-pgsql on OSDL's 8-way STP machines. I think they're
> PIII Xeons with 2MB L2 cache.
> 
> I had been having some difficulty running them recently, but I might
> have just worked out what the problem was, so hopefully I can benchmark
> the patchset I just sent to Andrew (plus fixes from Ingo, etc).
> 

Nope. Still not working :P

