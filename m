Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVJSLkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVJSLkZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJSLkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:40:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28622 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750773AbVJSLkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:40:24 -0400
Date: Wed, 19 Oct 2005 13:40:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051019114033.GA1580@elte.hu>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu> <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu> <Pine.LNX.4.61.0510190311140.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510190311140.1386@scrub.home>
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

> > so i can only repeat that ktimers is a generic timer subsystem, with a 
> > focus on _actually delivering a timer event_.
> 
> It doesn't answer it at all. The new timer system is definitively not 
> "usable for any kernel purpose", it has certain properties, which 
> makes it only applicable under certain conditions.

what "certain properties" and under what "certain conditions"? Please 
provide specifics to prove your point. I repeat for the third time: 
ktimers is a generic timer subsystem, with a focus on timer event 
delivery.

	Ingo
