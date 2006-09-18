Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWIREgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWIREgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 00:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWIREgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 00:36:43 -0400
Received: from opersys.com ([64.40.108.71]:50449 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751562AbWIREgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 00:36:42 -0400
Message-ID: <450E2739.7020008@opersys.com>
Date: Mon, 18 Sep 2006 00:57:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
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
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <450E1D2E.3080705@opersys.com> <20060918040947.GA21191@elte.hu>
In-Reply-To: <20060918040947.GA21191@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> That suggestion is so funny to me that i'll let it stand here in its 
> absurdity :) Did i get it right, you are suggesting for LTT to build a 
> full SystemTap interpreter, an script-to-C compiler, an embedded-C 
> script interpreter, just to be able to build-time generate the SystemTap 
> scripts back into the source code? Dont you realize that you've just 
> invented SystemTap, sans the ability to remove inactive code? ;)

Yes, an arbitrary factual fallacy for a change. I won't even get into
how trivial it would be to hack the SystemTap interpreter for the
purposes I state. Or any other part of your supposed argument for
that matter. Anyone seeking to implement what I outlined already has
plenty of information.

> I know a much easier method: a "static tracer" can do all of that (and 
> more), if you rename "SystemTap" to "static tracer" ;-)

There is no point to debate further. You clearly have no intention of
having the decency to stand tall, make a man of yourself and
acknowledge that you were shown wrong. No matter what I put forward,
you're going to stubbornly reply and construct false arguments to
defend a now indefensible point of view -- all the while making those
snide remarks about the time you are wasting and all (that's a
classic, by the way, for presumed experts when loosing face.)

Go back, Ingo, and read my earlier posts regarding what such attitude
has in terms of encouraging input from outsiders.

I, personally, have said everything that needed to be said. The record
is there if someone is looking for the answers. I only chose to come
back to make sure the following semantic distinction clear:
markup != mechanism != event list. And I've proven that, whether you'd
care to acknowledge it or not.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
