Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVBQQNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVBQQNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVBQQNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:13:24 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:38773 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262302AbVBQQNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:13:06 -0500
Message-ID: <4214C28F.6060608@yahoo.com.au>
Date: Fri, 18 Feb 2005 03:13:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> <Pine.LNX.4.58.0502170754110.2383@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502170754110.2383@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 18 Feb 2005, Nick Piggin wrote:
> 
>>I am pretty surprised myself that I was able to consolidate
>>all "page table range" functions into a single type of iterator
>>(well, there are a couple of variations, but it's not too bad).
> 
> 
> Ok, this is post-2.6.11 material, so please remind me.
> 

Sure... it will probably be best to go through -mm, but either
way I'll package the patches up nicely and rediff them against
2.6.11 when it comes out.

