Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWIOOOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWIOOOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWIOOON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:14:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25984 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751491AbWIOOOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:14:12 -0400
Message-ID: <450AB506.30802@sgi.com>
Date: Fri, 15 Sep 2006 16:13:26 +0200
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
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
In-Reply-To: <450AB5F9.8040501@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Paul Mundt wrote:
>> subjective, LTT proved that this was a problem regarding general
>> code-level intrusiveness when the number of tracepoints in relatively
>> close locality started piling up based on what people considered
>> arbitrarily useful, and LTTng doesn't appear to do anything to address
>> this.
> 
> "LTT proved that ..." what are you talking about? Have you noticed
> the posting earlier regarding the fact that the ltt tracepoints did
> not change over a 5 year span? **five** years ... Where do you get
> this claim that ltt trace points "started piling up"? Have a look
> at figure 2 of this article and let me know exactly which of those
> tracepoints are actually a problem to you:

Because other people have tried to use LTT for additional projects,
but said projects haven't been integrated into LTT. In other words,
just because *you* haven't added those, doesn't mean someone else
won't try and do it later, if LTT was integrated.

Nice try!

Jes
