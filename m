Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVJQQkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJQQkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVJQQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:40:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12943 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750780AbVJQQkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:40:07 -0400
Date: Mon, 17 Oct 2005 18:39:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017163958.GA4897@elte.hu>
References: <1129016558.1728.285.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com> <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu> <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu> <Pine.LNX.4.61.0510171825410.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171825410.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Mon, 17 Oct 2005, Ingo Molnar wrote:
> 
> > if a dozen mails werent enough then one more probably wont make a 
> > difference,
> 
> Just for the record: in this thread I got exactly three answers from 
> Thomas. I don't know where you got the other nine mails from, maybe 
> you could forward them to me, as they seem to contain the "patient 
> explanations" I'm missing.

here are all the replies from Thomas, regarding ktimers:

12359   * Sep 22 Thomas Gleixner ( 319) Re: [ANNOUNCE] ktimers subsystem
12362   * Sep 23 Thomas Gleixner (  49) Re: [ANNOUNCE] ktimers subsystem
12363   * Sep 23 Thomas Gleixner ( 235) Re: [ANNOUNCE] ktimers subsystem
12367   * Sep 24 Thomas Gleixner ( 214) Re: [ANNOUNCE] ktimers subsystem
12368   * Sep 25 Thomas Gleixner (  25) Re: [ANNOUNCE] ktimers subsystem
12369   * Sep 25 Thomas Gleixner (  17) Re: [ANNOUNCE] ktimers subsystem
12370   * Sep 25 Thomas Gleixner (  10) Re: [ANNOUNCE] ktimers subsystem
12387   * Oct 01 Thomas Gleixner ( 817) Re: [PATCH]  ktimers subsystem 2.6.14-rc
12419   * Oct 11 Thomas Gleixner (  41) Re: [PATCH]  ktimers subsystem 2.6.14-rc
12434   * Oct 16 Thomas Gleixner (  40) Re: [PATCH]  ktimers subsystem 2.6.14-rc

some of them very large and detailed.

	Ingo
