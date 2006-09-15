Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWIOOki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWIOOki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWIOOki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:40:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40068 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751591AbWIOOkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:40:36 -0400
Message-ID: <450ABB26.8020800@sgi.com>
Date: Fri, 15 Sep 2006 16:39:34 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Paul Mundt <lethal@linux-sh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
In-Reply-To: <450AB957.2050206@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Jes Sorensen wrote:
>> Because other people have tried to use LTT for additional projects,
>> but said projects haven't been integrated into LTT. In other words,
>> just because *you* haven't added those, doesn't mean someone else
>> won't try and do it later, if LTT was integrated.
> 
> Thank you. I will take it as a complement and likely laminate this
> email for your suggestion that I've acted responsibly in my
> maintenance of ltt. Boy, can you imagine what this debate would
> have looked like if I had included precisely those additional
> projects ...

Karim,

Thank you for this, it just proves that taking this discussion any
further is a waste of everybody's time.

> C'mon Jes, if I was able to responsibly maintain ltt over 5
> years *out* of the tree and I'm being labeled as incompetent all
> over this thread, then imagine what the very competent people
> maintaining the kernel could actually do.

Nobody ever said you were irresponsible, but you are claiming that you
are able to define a finite set of static tracepoints that are relevant
to everybody. Or in other words, they are defined as being the ones
relevant to you.

Please read Paul Mundt's response to your email - it's bang on, couldn't
put it any better myself.

Jes

