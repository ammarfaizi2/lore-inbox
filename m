Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUBXVLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUBXVK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:10:59 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:48399 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262460AbUBXVKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:10:45 -0500
Message-ID: <403BC021.3010709@techsource.com>
Date: Tue, 24 Feb 2004 16:20:33 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Heil <kerndev@sc-software.com>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Thomas Zehetbauer <thomasz@hostmaster.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org> <1077584461.8414.164.camel@hostmaster.org> <Pine.LNX.4.58.0402231707220.13525@scsoftware.sc-software.com> <403B5257.2030305@techsource.com> <20040224194354.GA13816@bitwizard.nl> <Pine.LNX.4.58.0402241147550.13525@scsoftware.sc-software.com>
In-Reply-To: <Pine.LNX.4.58.0402241147550.13525@scsoftware.sc-software.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Heil wrote:
> On Tue, 24 Feb 2004, Rogier Wolff wrote:
> 
> 
>>Date: Tue, 24 Feb 2004 20:43:54 +0100
>>From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
>>To: Timothy Miller <miller@techsource.com>
>>Cc: John Heil <kerndev@sc-software.com>,
>>     Thomas Zehetbauer <thomasz@hostmaster.org>,
>>     Kernel Mailing List <linux-kernel@vger.kernel.org>
>>Subject: Re: Intel vs AMD x86-64
>>
>>On Tue, Feb 24, 2004 at 08:32:07AM -0500, Timothy Miller wrote:
>>
>>>Things may have changed, but when I last built a Linux box (Athlon XP
>>>2800+), I was not able to find a motherboard for recent AMD processors
>>>with 64bit/66mhz PCI slots.  If I'd needed that, I would have had to go
>>>with Intel.
>>
>>Ehmm. We've been trying to get 64/66 slots in our systems a while, and
>>the only affordable option I've been able to find are the dual-athlon
>>boards (Tyan, Asus).
> 
> 
> 
> And so far, I've found Tyan to be the slightly more reliable of the two.


The problem was that the Tyan I found which did 64/66 was a dual 
processor board (not a problem) that had a maximum FSB of 266mhz (or 
maybe it was 200?).  I would have been stuck with dual Athlon XP 2400+ 
(or worse), rather than something faster like the 2800+ I have.  Well, 
the dual would be faster if I were running multi-threaded applications, 
but most of the CPU-intensive stuff I tend to tinker with is 
single-threaded and also memory-intensive, making the single 2800+ more 
attractive (I could have gotten the 3000+, but the cost increase wasn't 
worth the small performance increase).



