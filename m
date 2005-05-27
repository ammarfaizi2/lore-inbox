Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVE0JbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVE0JbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVE0J33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:29:29 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49571
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262412AbVE0JWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:22:34 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050527091432.GB20512@elte.hu>
References: <20050524184351.47d1a147.akpm@osdl.org>
	 <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org>
	 <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de>
	 <1117184630.6736.415.camel@tglx.tec.linutronix.de>
	 <20050527091432.GB20512@elte.hu>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 27 May 2005 11:22:52 +0200
Message-Id: <1117185772.6736.424.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 11:14 +0200, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > But keep
> > > the basic fundamental operations fast please (at least that used to be one
> > > of the Linux mottos that served it very well for many years, although more
> > > and more people seem to forget it now) 
> > 
> > "It has been that way since ages" arguments are not really productive in
> > a discussion. [...]
> 
> to make sure the wide context has not been lost: no way is IRQ threading 
> ever going to be the main or even the preferred mode of operation.

Sure, I did not imply to make it the standard behaviour. It's a feature
beside other more or less useful ones.

tglx

> NOT-Signed-off-by: Ingo Molnar <mingo@elte.hu>

:)


