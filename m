Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFNAte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFNAte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVFNAte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:49:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10991 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261167AbVFNAt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:49:29 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
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
Organization: MontaVista
Date: Mon, 13 Jun 2005 17:48:56 -0700
Message-Id: <1118710136.2725.36.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
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


That's depressing .. You not ever submitting IRQ threading upstream ?

Daniel

