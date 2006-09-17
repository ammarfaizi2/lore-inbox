Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWIQQDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWIQQDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWIQQDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 12:03:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:38074 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964980AbWIQQDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 12:03:14 -0400
Date: Sun, 17 Sep 2006 18:02:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060917152527.GC20225@elte.hu>
Message-ID: <Pine.LNX.4.64.0609171744570.6761@scrub.home>
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home>
 <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
 <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home>
 <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
 <20060917152527.GC20225@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> > The foremost issue is still that there is only limited kprobes 
> > support.
> 
> > The main issue in supporting static tracers are the tracepoints and so 
> > far I haven't seen any convincing proof that the maintainance overhead 
> > of dynamic and static tracepoints has to be significantly different.
> 
> to both points i (and others) already replied in great detail - please 
> follow up on them. (I can quote message-IDs if you cannot find them.)

What you basically tell me is (rephrased to make it more clear): Implement 
kprobes support or fuck off! You make it very clear, that you're unwilling 
to support static tracers even to point to make _any_ static trace support 
impossible. It's impossible to discuss this with you, because you're 
absolutely unwilling to make any concessions. What am I supposed to do 
than it's very clear to me, that you don't want to make any compromise 
anyway? You leave me _nothing_ to work with, that's the main reason I 
leave such things unanswered. AFAICT there is nothing I can do about that 
than just repeating what I told you already anyway and you'll continue to 
ignore it and I'm sick and tired of it.

bye, Roman
