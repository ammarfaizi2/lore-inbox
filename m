Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265124AbSJaN13>; Thu, 31 Oct 2002 08:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265223AbSJaN13>; Thu, 31 Oct 2002 08:27:29 -0500
Received: from iris.mc.com ([192.233.16.119]:1749 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S265124AbSJaN12>;
	Thu, 31 Oct 2002 08:27:28 -0500
Message-Id: <200210311333.IAA19333@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: What's left over.
Date: Thu, 31 Oct 2002 09:36:50 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > POSIX Timer API
>
> I think I'll do at least the API, but there were some questions about the
> config options here, I think.

I think george just posted a config optionless patch.

WOOHOO!  Thanks!

>
> > Hires Timers
>
> This one is likely another "vendor push" thing.
>

I work for a vendor who really wants this.  

we have customers who demand it.

I am sure we are not alone (mvista? concurrent? any embedded space people for 
whom 10msec is not good enough and the extra overhead of a higer frequency 
fixed interval timer is unacceptable please speak up, if we don't get it in 
now, we probably won't get it for 2 years.)

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
**************************************************/
