Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVEaO2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEaO2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVEaO2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:28:24 -0400
Received: from 65-102-103-67.albq.qwest.net ([65.102.103.67]:15587 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261720AbVEaO2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:28:22 -0400
Date: Tue, 31 May 2005 08:30:48 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Bill Huey <bhuey@lnxw.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0505310828450.12903@montezuma.fsmlabs.com>
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
 <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
 <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
 <20050528054503.GA2958@nietzsche.lynx.com> <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 May 2005, Zwane Mwaikambo wrote:

> On Fri, 27 May 2005, Bill Huey wrote:
> 
> > > It isn't clear to me yet. I'm sure you can make your interrupt
> > > latencies look good, as with your scheduling latencies. But when
> > 
> > My project was getting a solid spike at 4 usec for irq-thread
> > startups and Ingo's stuff is better. It's already there.
> 
> Is that worst case?

So is that some sort of observable worst case value with a suitable 
stress test load? You didn't answer this in your reply. I'll be setting up 
my own test system soon to have a better look.

Thanks,
	Zwane
