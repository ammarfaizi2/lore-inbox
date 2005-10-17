Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVJQRfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVJQRfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVJQRfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:35:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:30119 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751181AbVJQRfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:35:46 -0400
Date: Mon, 17 Oct 2005 19:35:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017173535.GB5719@elte.hu>
References: <434DA06C.7050801@mvista.com> <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu> <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu> <Pine.LNX.4.61.0510171825410.1386@scrub.home> <20051017163958.GA4897@elte.hu> <Pine.LNX.4.61.0510171852000.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171852000.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > Just for the record: in this thread I got exactly three answers 
> > > from Thomas. I don't know where you got the other nine mails from, 
> > > maybe you could forward them to me, as they seem to contain the 
> > > "patient explanations" I'm missing.
> > >
> > here are all the replies from Thomas, regarding ktimers:
> > 
> > 12359   * Sep 22 Thomas Gleixner ( 319) Re: [ANNOUNCE] ktimers subsystem
> > 12362   * Sep 23 Thomas Gleixner (  49) Re: [ANNOUNCE] ktimers subsystem
> > 12363   * Sep 23 Thomas Gleixner ( 235) Re: [ANNOUNCE] ktimers subsystem
> > 12367   * Sep 24 Thomas Gleixner ( 214) Re: [ANNOUNCE] ktimers subsystem
> > 12368   * Sep 25 Thomas Gleixner (  25) Re: [ANNOUNCE] ktimers subsystem
> > 12369   * Sep 25 Thomas Gleixner (  17) Re: [ANNOUNCE] ktimers subsystem
> > 12370   * Sep 25 Thomas Gleixner (  10) Re: [ANNOUNCE] ktimers subsystem
> 
> Different thread and not directly related to issues with the patch.

ugh, what were they about then, poetry?

Ah i think i know what you mean: these were about a PREVIOUS VERSION of 
the patch, and hence they fell off the face of the earth, regardless of 
their content, right? What a tricky little definition of "Thomas replied 
only 3 times" ...

> > 12387   * Oct 01 Thomas Gleixner ( 817) Re: [PATCH]  ktimers subsystem 2.6.14-rc
> > 12419   * Oct 11 Thomas Gleixner (  41) Re: [PATCH]  ktimers subsystem 2.6.14-rc
> > 12434   * Oct 16 Thomas Gleixner (  40) Re: [PATCH]  ktimers subsystem 2.6.14-rc
> 
> That's the only mails related to the patch.

your latest mail with the list of 'open' issues seems to contradict your 
assertion that the above 3 mails from Thomas where "the only mails 
related to the patch". E.g.:

' - "timer API" vs "timeout API": I got absolutely no acknowlegement 
     that this might be a little confusing and in consequence "process 
     timer" may be a better name. '

was raised and discussed in the first chunk of mails just as well.

	Ingo
