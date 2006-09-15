Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWIOUzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWIOUzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWIOUzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:55:52 -0400
Received: from opersys.com ([64.40.108.71]:30219 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932260AbWIOUzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:55:51 -0400
Message-ID: <450B15B0.3060200@opersys.com>
Date: Fri, 15 Sep 2006 17:05:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>	 <20060915132052.GA7843@localhost.usen.ad.jp>	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>		 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>	 <1158332447.5724.423.camel@localhost.localdomain>	 <20060915111644.c857b2cf.akpm@osdl.org>	 <1158348954.5724.481.camel@localhost.localdomain>	 <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain>
In-Reply-To: <1158351780.5724.507.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> Stop whining!

I resent that. If your efforts in working on popular kernel topics
met rapid reward then I'm happy for you. The fact that others tackle
unpopular topics and persist despite constant personal attacks should
nevertheless be recognized for what it is.

> LTT did not manage to solve the problem in a generic,

You're entirely correct. I never claimed it to be perfect, that's why I
had approached others early on to try to bridge things together and
that's why I used to post ltt patches to the lkml.

> mainline acceptable way. If you really believe that Kprobes / Systemtap
> is just a $corporate maliciousness to kick you out of business, then I
> really start to doubt your sanity.

If that's how it was read, then it wasn't written right. ltt was never
really a profit center for me, embedded Linux training was -- you
wouldn't believe how much more profitable training is than pure
consulting. But my own business is just beside the point. My point
was that the high barrier to entry for tracing fragmented efforts
around it. As for corporate decisions which culminated from such
resistance, they probably were the sanest decision to take at the
time. Heck if I was a manager at any of those companies I would have
likely taken the same decision. It was, and still is, though,
counterproductive. Fully justifiable, but counterproductive.

Karim
