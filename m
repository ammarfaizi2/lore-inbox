Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUJFCDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUJFCDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUJFCDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:03:09 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:4443 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266683AbUJFCDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:03:06 -0400
Message-ID: <41635248.5090903@yahoo.com.au>
Date: Wed, 06 Oct 2004 12:02:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Robert Love <rml@novell.com>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org>
In-Reply-To: <20041006015515.GA28536@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Tue, Oct 05, 2004 at 09:52:55PM -0400, Robert Love wrote:
> 
>>On Tue, 2004-10-05 at 21:40 -0400, Jeff Garzik wrote:
>>
>>
>>>And with preempt you're still hiding stuff that needs fixing.  And when 
>>>it gets fixed, you don't need preempt.
>>>
>>>Therefore, preempt is just a hack that hides stuff that wants fixing anyway.

What is it hiding exactly?

>>
>>This actually sounds like the argument for preempt, and against
> 
> 
> As opposed to fixing drivers???  Please fix the drivers and code first.
> 

I thought you just said preempt should be turned off because it
breaks things (ie. as opposed to fixing the things that it breaks).

But anyway, yeah obviously fixing drivers always == good. I don't
think anybody advocated otherwise.
