Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291738AbSBTPsa>; Wed, 20 Feb 2002 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291713AbSBTPsL>; Wed, 20 Feb 2002 10:48:11 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53516 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291692AbSBTPsD>; Wed, 20 Feb 2002 10:48:03 -0500
Date: Wed, 20 Feb 2002 10:46:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: george anzinger <george@mvista.com>
cc: Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <3C72BBBA.FB79F6D0@mvista.com>
Message-ID: <Pine.LNX.3.96.1020220104257.23280J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, george anzinger wrote:

> Bill Davidsen wrote:
> > 
> > On Mon, 18 Feb 2002, Ben Greear wrote:

> > > Does this problem still exist on 64-bit machines?
> > 
> > Absolutely. But not as often ;-)
> 
> Actually you will have a VERY hard time getting it to roll over.  Issues
> of your life time, not to mention the hardware's life time.  64 bits
> makes a VERY large number and you are counting in 427 day increments. 
> Remember we have been counting seconds since 1970 in 32 bits and
> rollover is still, most likely, beyond the capability of any machine
> running today to get to.  Now consider counting in 427 day increments
> instead of seconds.

Um, note the odd characters appended to my sentence ";-)" which means
"not serious here, look for joke, sarcasm, over or understatement.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

