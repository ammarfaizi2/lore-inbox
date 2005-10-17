Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVJQLAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVJQLAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVJQLAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:00:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13012 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932265AbVJQLAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:00:32 -0400
Date: Mon, 17 Oct 2005 13:00:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: zippel@linux-m68k.org, tglx@linutronix.de, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017110006.GA10638@elte.hu>
References: <1129016558.1728.285.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com> <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home> <20051017075917.GA4827@elte.hu> <Pine.LNX.4.61.0510171054430.1386@scrub.home> <20051017094153.GA9091@elte.hu> <20051017025657.0d2d09cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017025657.0d2d09cc.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > > [...] It will waste my time, I could spend on other projects and it 
> >  > will put Andrew in the unfortunate position to decide, which patch to 
> >  > accept. [...]
> > 
> >  yes, please, put Andrew (and me too) into that unfortunate position!  
> >  Please, pretty please, get on with the patches!
> 
> I'm with Roman on this one - the old "show me the code" trick which 
> people use to quash other people's objections is rather poor form - we 
> should simply address the objections as raised.
> 
> That being said, I'll confess that I've largely ignored this 
> discussion in the hope that things would get sorted out.  Seems that 
> this won't be happening and as Roman's opinions carry weight I do 
> intend to solicit a (brief!) summary of his objections from him when 
> the patch comes round again.  Sorry.

Fine with me. A brief summary of technical objections (without any 
personal attacks) is all we wanted to have to begin with. "Show me the 
code" was my last-ditch attempt to move this seemingly unmovable 
discussion from a communication channel where the chemistry doesnt seem 
to work out to a more objective format.

	Ingo
