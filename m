Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965598AbWIRJBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965598AbWIRJBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965599AbWIRJBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:01:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30188 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965598AbWIRJBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:01:41 -0400
Message-ID: <450E604E.90305@sgi.com>
Date: Mon, 18 Sep 2006 11:01:02 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home> <20060917150953.GB20225@elte.hu> <Pine.LNX.4.64.0609171816390.6761@scrub.home> <20060917234152.GA20374@elte.hu> <Pine.LNX.4.64.0609180214320.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609180214320.6761@scrub.home>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Mon, 18 Sep 2006, Ingo Molnar wrote:
> 
>> Was it truly confusing to you what i said?
> 
> Not really, it's pretty clear, that you don't want me (or any other user 
> of an arch, which doesn't support kprobes) cut some slack, so that I can 
> make use of tracing. :-(

Roman,

I have a PDF of the m68k instruction set sitting somewhere, do you want
me to forward you a copy so you can implement kprobe support for m68k?

Sorry, for the sarcasm, but that argument is just pointless, it doesn't
add any value that you keep repeating it!

Jes
