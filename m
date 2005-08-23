Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVHWSCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVHWSCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVHWSCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:02:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52215 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932263AbVHWSCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:02:21 -0400
Subject: Re: 2.6.12 Performance problems
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: danial_thom@yahoo.com
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
References: <20050823171028.47315.qmail@web33309.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 11:02:13 -0700
Message-Id: <1124820134.15265.30.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 10:10 -0700, Danial Thom wrote:
> 

> > >Ok, well you'll have to explain this one:
> > >
> > >"Low latency comes at the cost of decreased
> > >throughput - can't have both"
> > >  
> > >
> > Configuring "preempt" gives lower latency,
> > because then
> > almost anything can be interrupted (preempted).
> >  You can then
> > get very quick responses to some things, i.e.
> > interrupts and such.
> 
> I think part of the problem is the continued
> misuse of the word "latency". Latency, in
> language terms, means "unexplained delay".

latency

n 
1: (computer science) the time it takes for a specific block of data on
a data track to rotate around to the read/write head [syn: rotational
latency] 
2: the time that elapses between a stimulus and the response to it [syn:
reaction time, response time, latent period] 
3: the state of being not yet evident or active

No apparent references to "unexplained" in association with the word
latency.




