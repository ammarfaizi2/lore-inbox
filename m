Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUDEWF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUDEWE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:04:58 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:26373 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262625AbUDEWE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:04:29 -0400
Message-ID: <4071DCC3.9090106@techsource.com>
Date: Mon, 05 Apr 2004 18:25:07 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Stephen Smoogen <smoogen@lanl.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405205412.60071.qmail@web40504.mail.yahoo.com> <4071CF6E.4030104@techsource.com> <Pine.LNX.4.58.0404051516210.24230@smoogen1.lanl.gov>
In-Reply-To: <Pine.LNX.4.58.0404051516210.24230@smoogen1.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Smoogen wrote:
> On Mon, 5 Apr 2004, Timothy Miller wrote:
> 
> 
>>Sergiy Lozovsky wrote:
>>
>>
>>>
>>>All LISP errors are incapsulated within LISP VM.
>>> 
>>
>>
>>A LISP VM is a big, giant, bloated.... *CHOKE* *COUGH* *SPUTTER* 
>>*SUFFOCATE* ... thing which SHOULD NEVER be in the kernel.
> 
> 
> Ah your thinking of the days when 1 meg of memory was a lot and LISP was 
> considered huge..  With 4 gigs of memory today, it shouldnt be a problem 
> :). Actually a LISP vm can fit into a small amount of memory depending 
> on what you want it to do... 

People complained about having Athlon-specific fixes in all x86 kernels 
because of the extra few hundred bytes it would waste for a Pentium kernel.

What makes you think people would accept a LISP interpreter?

