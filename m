Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWIQVxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWIQVxg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWIQVxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:53:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:39869 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965125AbWIQVxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:53:36 -0400
Date: Sun, 17 Sep 2006 23:52:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060917212345.GB2145@elte.hu>
Message-ID: <Pine.LNX.4.64.0609172347450.6761@scrub.home>
References: <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
 <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
 <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home>
 <450D8C58.5000506@yahoo.com.au> <Pine.LNX.4.64.0609172027120.6761@scrub.home>
 <20060917212345.GB2145@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> btw., you still have not retracted or corrected your false suggestion 
> that "concessions" or a "compromise" were possible and you did not 
> retract or correct your false accusation that i "dont want to make 
> them":

Sorry, I have nothing to retract and I'm not interesting in playing your 
word games. :-(

> > It's impossible to discuss this with you, because you're absolutely 
> > unwilling to make any concessions. What am I supposed to do than it's 
> > very clear to me, that you don't want to make any compromise anyway?
> 
> while, as i explained it before, such a concession simply does not exist 
> - so i am not in the position to "make such a concession". There are 
> only two choices in essence: either we accept a generic static tracer, 
> or we reject it.

Wrong, this is about the minimum support, which can be used by both static 
and dynamic tracers.

bye, Roman
