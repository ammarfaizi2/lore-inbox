Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTJQQHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTJQQHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:07:46 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:45990 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263489AbTJQQHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:07:43 -0400
Subject: Re: killing a kernel thread.
From: David Woodhouse <dwmw2@infradead.org>
To: root@chaos.analogic.com
Cc: Suresh Subramanian <Suresh.Subramanian@lntinfotech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0310171143450.3689@chaos>
References: <OFE97AECC7.A7E1AF0C-ON65256DC2.0046781F@lntinfotech.com>
	 <Pine.LNX.4.53.0310170950290.3209@chaos>
	 <1066405067.6744.1444.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.53.0310171143450.3689@chaos>
Content-Type: text/plain
Message-Id: <1066406850.6744.1462.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Fri, 17 Oct 2003 17:07:31 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 11:49 -0400, Richard B. Johnson wrote:
> Well it isn't RBJcode. It's Intel code. Look who wrote it
> before you give me any credit, especially your kind of "credit".

You deserve the same 'credit' for quoting code from a known purveyor of
crap code as you'd deserve for writing it yourself. Although to their
credit Intel do seem to be capable of writing slightly better code these
days than they used to.

> Also, Intel machines have 32-bit longs which are identical to
> 32-bit ints and this was an Intel driver........

Even some Intel machines have 64-bit longs nowadays. Certainly there's
no excuse for that particular error. It's just a gratuitous
non-portability.

> Have fun growing up.

You have to let me have fun -- it's boring just correcting you every
time you mislead a newbie.

I wouldn't bother if you weren't just picking on people who don't know
better, but if you're going to cruelly post utterly broken code in
response to a genuine question, someone needs to say something.

-- 
dwmw2

