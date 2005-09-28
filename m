Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVI1LzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVI1LzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 07:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVI1LzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 07:55:20 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:65488 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S1751219AbVI1LzT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 07:55:19 -0400
X-OB-Received: from unknown (205.158.62.55)
  by wfilter.us4.outblaze.com; 28 Sep 2005 11:55:18 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Simon White" <s_a_white@email.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>
Date: Wed, 28 Sep 2005 06:55:18 -0500
Subject: Re: Best Kernel Timers?
X-Originating-Ip: 193.195.77.146
X-Originating-Server: ws1-3.us4.outblaze.com
Message-Id: <20050928115518.DB7F3101D9@ws1-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not really sure what you have against patches?  If you have to wait
> for this to be in the mainline, you are going to be disappointed.

Me, personally nothing, but trying to get every user of a catweasel or
hardsid card to patch there kernel is the problem.

For those that do wish to patch there systems I have alternative
better realtime code.  For those that don't I wanted something that
would approximately work as I had before.

As a note I've found it bad enough to try and get users to build the
normal drivers for there prebuilt kernels... with various requests
as to please put this in mainline (although not ready for that) so
it comes pre-built and installed for there system.

If there are no currently in mainline even approaching suitable clocks
(why I asked) then I'll resort to some custom busy waiting mechanism :(.

Thankyou for helping.
Simon


-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

