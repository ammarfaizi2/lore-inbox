Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWIOOyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWIOOyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWIOOyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:54:16 -0400
Received: from opersys.com ([64.40.108.71]:47111 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751609AbWIOOyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:54:16 -0400
Message-ID: <450AC0F3.6080008@opersys.com>
Date: Fri, 15 Sep 2006 11:04:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Paul Mundt <lethal@linux-sh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <450ABB26.8020800@sgi.com>
In-Reply-To: <450ABB26.8020800@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen wrote:
> Thank you for this, it just proves that taking this discussion any
> further is a waste of everybody's time.

Sorry you feel this way.

> Nobody ever said you were irresponsible, but you are claiming that you
> are able to define a finite set of static tracepoints that are relevant
> to everybody. Or in other words, they are defined as being the ones
> relevant to you.

No, I'm precisely not claiming that the tracepoints I was looking for
were "relevant to everybody". They are, however, very relevant to any
standard sysadmin or developer who wants to get a better picture of
what his kernel is doing. Again, please refer to figure 2 of this
article and explain to me why it's not relevant for standard users
and developers to understand when these events happen inside the
kernel:
http://www.usenix.org/events/usenix2000/general/full_papers/yaghmour/yaghmour_html/index.html

Karim
