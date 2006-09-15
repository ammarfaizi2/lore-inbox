Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWIOVRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWIOVRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWIOVRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:17:04 -0400
Received: from www.osadl.org ([213.239.205.134]:23014 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932271AbWIOVRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:17:01 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <450B15B0.3060200@opersys.com>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>
	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
			 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
	 <1158332447.5724.423.camel@localhost.localdomain>
	 <20060915111644.c857b2cf.akpm@osdl.org>
	 <1158348954.5724.481.camel@localhost.localdomain>
	 <450B0585.5070700@opersys.com>
	 <1158351780.5724.507.camel@localhost.localdomain>
	 <450B15B0.3060200@opersys.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 23:17:50 +0200
Message-Id: <1158355070.5724.524.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 17:05 -0400, Karim Yaghmour wrote:
> Thomas Gleixner wrote:
> > Stop whining!
>
> I resent that. 

See last sentence of this mail.

> If your efforts in working on popular kernel topics
> met rapid reward then I'm happy for you. The fact that others tackle
> unpopular topics and persist despite constant personal attacks should
> nevertheless be recognized for what it is.

Oh well. I'm working on unpopular and intrusive stuff as long as you do.
Just our ways to work and communicate differ slightly.

> > mainline acceptable way. If you really believe that Kprobes / Systemtap
> > is just a $corporate maliciousness to kick you out of business, then I
> > really start to doubt your sanity.
> 
> If that's how it was read, then it wasn't written right

Ouch. Can you please tell me what's the technical merit of this
paragraph:

"                               ... The only reasons
there are separate project teams is because managers in key
positions made the decision that they'd rather break from existing
projects which had had little success mainlining and instead use
their corporate bodyweight to pressure/seduce kernel developers
working for them into pushing their new great which-aboslutely-
has-nothing-to-do-with-this-ltt-crap-(no,no, we actually agree
with you kernel developers that this is crap, this is why we're
developing this new amazing thing). That's the truth plain and
simple."

Sorry, I have not found a way to interpret it usefully.

	tglx


