Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWJADwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWJADwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 23:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWJADwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 23:52:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61675 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751836AbWJADwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 23:52:15 -0400
Message-ID: <451F3B6D.9060007@garzik.org>
Date: Sat, 30 Sep 2006 23:52:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Netdev List <netdev@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: netdev-2.6.git frozen
References: <451F3A8F.7040608@garzik.org>
In-Reply-To: <451F3A8F.7040608@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Similar to David's recent announcement, netdev-2.6.git is now closed to 
> new features.
> 
> Though really, [my fault] I should have posted this as soon as the merge 
> window opened.  The stuff that goes into each new release, when the 
> merge window opens, should be stuff that has already been through a 
> round of testing in -mm.
> 
> The updates presented in netdev -- e100, e1000, ixgb and sky2 -- will go 
> upstream tomorrow.  Everything else will be fixed.

s/fixed/fixes/

I wish "everything" was fixed, after tomorrow :)


> And the message for the future is:  don't wait until the merge window 
> opens, to submit your test.  Doing so means it doesn't get the normal 

s/test/code/

Apparently I need my morning Pepsi.


> amount of testing and review, and is thus discouraged.

