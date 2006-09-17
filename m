Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWIQT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWIQT5F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWIQT5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:57:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7612 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932374AbWIQT5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:57:02 -0400
Date: Sun, 17 Sep 2006 21:45:56 +0200 (CEST)
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
In-Reply-To: <20060917192359.GA24016@elte.hu>
Message-ID: <Pine.LNX.4.64.0609172144200.6761@scrub.home>
References: <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home>
 <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
 <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
 <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home>
 <20060917192359.GA24016@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> > > [...] I think Ingo said that some "static tracepoints" (eg. 
> > > annotation) could be acceptable.
> > 
> > No, he made it rather clear, that as far as possible he only wants 
> > dynamic annotations (e.g. via function attributes).
> 
> what you say is totally and utterly nonsensical misrepresentation of 
> what i have said. I always said: i support in-source annotations too (I 
> even suggested APIs how to do them),

Some consistency would certainly help:
'my suggested API is not "barely usable" for static tracers but "totally 
unusable".'

<20060916082214.GD6317@elte.hu>
