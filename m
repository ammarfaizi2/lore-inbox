Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWIOUgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWIOUgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWIOUgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:36:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53415 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932203AbWIOUgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:36:19 -0400
Date: Fri, 15 Sep 2006 22:35:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
       Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <1158350716.5724.488.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609152227080.6761@scrub.home>
References: <Pine.LNX.4.64.0609151339190.6761@scrub.home> 
 <1158323938.29932.23.camel@localhost.localdomain>  <Pine.LNX.4.64.0609151425180.6761@scrub.home>
  <1158327696.29932.29.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0609151523050.6761@scrub.home>  <1158331277.29932.66.camel@localhost.localdomain>
  <450ABA2A.9060406@opersys.com>  <1158332324.29932.82.camel@localhost.localdomain>
  <y0mmz91f46q.fsf@ton.toronto.redhat.com>  <1158345108.29932.120.camel@localhost.localdomain>
  <20060915181208.GA17581@elte.hu>  <Pine.LNX.4.64.0609152046350.6761@scrub.home>
 <1158350716.5724.488.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Thomas Gleixner wrote:

> > Who is going to implement this for every arch?
> > Is this now the official party line that only archs, which implement all 
> > of this, can make use of efficient tracing?
> 
> In the reverse you are enforcing an ugly - but available for all archs -
> solution due to the fact that there is nobody interested enough to
> implement it ?

Where is the proof that such solution is inherently ugly? (Note that 
just picking some example from LTT doesn't make a general proof.)
I am also not the one who wants to enforce a single solution onto 
everyone.

bye, Roman
