Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVHAKij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVHAKij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 06:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVHAKii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 06:38:38 -0400
Received: from b.relay.invitel.net ([62.77.203.4]:461 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP id S262085AbVHAKii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 06:38:38 -0400
Date: Mon, 1 Aug 2005 12:38:35 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
Message-ID: <20050801103835.GE28346@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <003401c58ea2$4dfd76f0$5601010a@ashley> <20050722132523.GJ20995@vega.lgb.hu> <42E517B6.1010704@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42E517B6.1010704@tmr.com>
X-Operating-System: vega Linux 2.6.11.11-grsec-vega i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 12:47:50PM -0400, Bill Davidsen wrote:
> Gábor Lénárt wrote:
> >On Fri, Jul 22, 2005 at 05:46:58PM +0800, Ashley wrote:
> >
> >>  I've a server with 2 Operton 64bit CPU and 12G memory, and this server 
> >>is used to run  applications which will comsume huge memory,
> >>the problem is: when this aplications exits,  the free memory of the 
> >>server is still very low(accroding to the output of "top"), and
> >>from the output of command "free", I can see that many GB memory was 
> >>cached by kernel. Does anyone know how to free the kernel cached
> >>memory? thanks in advance.
> >
> >
> >It's a very - very - very old and bad logic (at least nowdays) from the
> >stone age to free up memory.
> 
> It's very Microsoft to claim that the OS always knows best, and not let 
> the user tune the system the way they want it tuned. And if that means 
> to leave a bunch of free memory for absolute fastest availability, the 
> admin should have that option.

Sure, sorry if my comment can be treated in this way ... I mean surprising
amount of people I've met criticised Linux (well, some years ago when DOS
was popular) that he/she want to see that 'free memory' field reported eg by
'top' should be the maximum all the time ... I mean this way: this is the
behaviour which is quite wrong, I've written about this.

Sure, because of my not too good English, I may have missed the real meaning
of the mail, sorry about it!

-- 
- Gábor
