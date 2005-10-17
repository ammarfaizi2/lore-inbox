Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVJQJ6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVJQJ6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVJQJ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:58:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932241AbVJQJ6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:58:21 -0400
Date: Mon, 17 Oct 2005 02:56:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: zippel@linux-m68k.org, tglx@linutronix.de, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-Id: <20051017025657.0d2d09cc.akpm@osdl.org>
In-Reply-To: <20051017094153.GA9091@elte.hu>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0510100213480.3728@scrub.home>
	<1129016558.1728.285.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0510130004330.3728@scrub.home>
	<434DA06C.7050801@mvista.com>
	<Pine.LNX.4.61.0510150143500.1386@scrub.home>
	<1129490809.1728.874.camel@tglx.tec.linutronix.de>
	<Pine.LNX.4.61.0510170021050.1386@scrub.home>
	<20051017075917.GA4827@elte.hu>
	<Pine.LNX.4.61.0510171054430.1386@scrub.home>
	<20051017094153.GA9091@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > [...] It will waste my time, I could spend on other projects and it 
>  > will put Andrew in the unfortunate position to decide, which patch to 
>  > accept. [...]
> 
>  yes, please, put Andrew (and me too) into that unfortunate position!  
>  Please, pretty please, get on with the patches!

I'm with Roman on this one - the old "show me the code" trick which people
use to quash other people's objections is rather poor form - we should simply
address the objections as raised.

That being said, I'll confess that I've largely ignored this discussion in
the hope that things would get sorted out.  Seems that this won't be
happening and as Roman's opinions carry weight I do intend to solicit a
(brief!) summary of his objections from him when the patch comes round
again.  Sorry.
