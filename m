Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWIOUkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWIOUkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWIOUkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:40:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58023 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932232AbWIOUky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:40:54 -0400
Date: Fri, 15 Sep 2006 22:40:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <1158351780.5724.507.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609152236010.6761@scrub.home>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
  <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> 
 <20060915132052.GA7843@localhost.usen.ad.jp>  <Pine.LNX.4.64.0609151535030.6761@scrub.home>
  <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
   <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> 
 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
  <1158332447.5724.423.camel@localhost.localdomain>  <20060915111644.c857b2cf.akpm@osdl.org>
  <1158348954.5724.481.camel@localhost.localdomain>  <450B0585.5070700@opersys.com>
 <1158351780.5724.507.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Thomas Gleixner wrote:

> So this has to be changed. And requiring to recompile the kernel is the
> wrong answer. Having some nifty tool, which allows you to define the set
> of dynamic trace points or use a predefined one is the way to go.

Nobody is taking dynamic tracing away!
You make it sound that tracing is only possible via dynamic traces.
If I want to use static tracepoints, why shouldn't I?

> Stop whining!

So we're back to personal attacks now. :-(

bye, Roman
