Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbUA2Vdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUA2Vdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:33:42 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:36367 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266454AbUA2VdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:33:07 -0500
Message-ID: <40197CE3.2020205@techsource.com>
Date: Thu, 29 Jan 2004 16:36:35 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <200401292136.i0TLaR76000250@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200401292136.i0TLaR76000250@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Bradford wrote:

> 
> If we put 4 or more on each board, it could be useful for betting
> shops, stock markets, shop window displays, and other applications
> where you need to control a dozen or more screens, which basically
> contain textual information, but where 80x25 text mode just isn't
> enough.  I.E. you might want the odd pie chart or different sized text
> or something.

The market for secondary heads is too small.  You can get an ATI Mach 64 
PCI card for pennies and add it as a second head for what you're describing.

For an open-source graphics card to be marketable, it would have to be 
attractive as a primary head used in Linux workstations and servers, and 
it would have to be so in a PC market.

> 
> 
>>Oh, there's one thing I forgot.  It would have to support VGA.
> 
> 
> Maybe not, the primary market for this, (I.E. what makes it cost
> effective to produce, and therefore available for developers to use as
> their primary display), could be users who want to control many
> displays, and who would have a standard VGA card for the primary
> monitor.  (Yeah, it would be kind of ironic if 99% of our amasing new
> graphics cards ended up in mahines with another card as the primary
> display, but then again, if it makes the open hardware available for
> developers to experiment with at a reasonable cost, it would be worth
> doing).

The irony is too much.  Seriously.

> 
> So, what about a PCI card with four or eight 16MB framebuffers, and
> the basic acceleration and other specs you described above.  Is that
> at least slightly feasible, do you think?

Adding extra heads is relatively easy, and you can keep the memory 
unified and do it all in one chip.

