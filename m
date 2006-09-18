Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWIRRGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWIRRGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 13:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWIRRGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 13:06:30 -0400
Received: from dvhart.com ([64.146.134.43]:11493 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751853AbWIRRG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 13:06:29 -0400
Message-ID: <450ED213.9000603@mbligh.org>
Date: Mon, 18 Sep 2006 10:06:27 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
Cc: karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp>	<Pine.LNX.4.64.0609151535030.6761@scrub.home>	<20060915135709.GB8723@localhost.usen.ad.jp>	<450AB5F9.8040501@opersys.com>	<450AB506.30802@sgi.com>	<450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org> <450BCF97.3000901@sgi.com> <450C20C7.30604@opersys.com> <450E5540.4080205@sgi.com>
In-Reply-To: <450E5540.4080205@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And it doesn't address the following issues:
> 
> a) The static community providing actual evidence that dynamic tracing
>    is noticably slower.

...

> Everything has performance limitations, you keep running around touting
> that static is the only thing thats not a problem. Now show us the
> numbers!

When comparing two different approaches to a problem, it is unreasonable
and disingenuous to try to force the onus on the proponents of one
particular approach to do all the benchmarking for both sides. Everybody
has to help try to find the correct solution.

Furthermore, Mathieu already did provide numbers, if you go back and
look.

> The problems pointed out with LTT are *conceptual*, but of course you
> keep ignoring the facts and refusing to provide real numbers.

This is getting very silly, and unnecessarily abusive. Real problems
exist on both sides of the fence, which have been discussed ad nauseam.
If you don't recall them, then go back and read the thread again. The
question is how to strike a comprimise between two different set of
problems, which Ingo and Karim actually seemed to be making progress
on towards the end of the thread.

M.
