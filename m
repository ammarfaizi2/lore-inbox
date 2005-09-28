Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVI1KI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVI1KI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVI1KI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:08:59 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:57569 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1750864AbVI1KI6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:08:58 -0400
X-OB-Received: from unknown (205.158.62.55)
  by wfilter.us4.outblaze.com; 28 Sep 2005 10:08:58 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>
Date: Wed, 28 Sep 2005 05:08:58 -0500
Subject: Re: Best Kernel Timers?
X-Originating-Ip: 193.195.77.146
X-Originating-Server: ws1-3.us4.outblaze.com
Message-Id: <20050928100858.824F5101D9@ws1-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Have you taken a look at what is being done by Thomas Gleixner?
> 
> http://lwn.net/Articles/152363/

No didn't know of this, will take a look.

> 
> Also you may be interested in Ingo Molnar's RT kernel.
> 
> http://people.redhat.com/mingo/realtime-preempt/

Unless I'm mistaken this is a external patch i.e. not in mainline?
I do know of the work, but people willing to patch the kernel
should hopefully equally be able to cope with an rtai or rtlinux
patch.  If this is integrated into mainline I'll definately
check it out.

> 
> As well as the work being done by the HRT folks.
> 
> http://sourceforge.net/projects/high-res-timers
> 

I posted a similiar question there but received no response.  From
what I can tell it is a frame work for providing hardware specific
timer sources to the kernel and also exporting posix userspace
system calls from the kernel.  It may do more in kernel but haven't
found exactly what it does, relevent docs?  Also is this in mainline
(or soon to be) or just patches against it?

Thankyou for your response.

Simon


-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

