Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVF0UeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVF0UeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVF0UbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:31:00 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:32262 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261709AbVF0U3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:29:14 -0400
Message-ID: <42C0623E.5040405@tmr.com>
Date: Mon, 27 Jun 2005 16:31:58 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
References: <1119356601.3279.118.camel@localhost.localdomain>  <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>  <1119363150.3325.151.camel@localhost.localdomain>  <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>  <1119379587.3325.182.camel@localhost.localdomain>  <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl> <1119566026.18655.30.camel@localhost.localdomain> <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl> <42BC8C10.1040604@pobox.com> <Pine.LNX.4.61L.0506271516270.23903@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0506271516270.23903@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Fri, 24 Jun 2005, Jeff Garzik wrote:
> 
> 
>>>Well, keyboard and mouse are USB these days, serial and parallel are PCI,
>>>floppies are not used anymore and the ISA DMA controller would only be 
>>
>>Oh, how I wish this were true!
>>
>>The pre-production machines I get (i.e. not even on the market yet) still have
>>floppy, serial, and PS/2 kbd/mouse.
> 
> 
>  You must be getting them from wrong vendors. ;-)  How about switching to 
> a reasonable platform that doesn't imply DOS compatibility?

What's reasonable about a system without serial connectivity? Damn hard 
to debug with a serial console without one. Yes you can get around it, 
but it's one more issue to address. PS/2? I have enough KVM hardware in 
place to make that non-sales point, and I bet that there are lots of 
people with some fancy mouse, or keyboard, or game thingie, that it's 
cheaper to keep the features than drop them. I don't know if the ATX 
standard requires them, but low cost features are hard to drop.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
