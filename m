Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWIOXaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWIOXaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWIOXaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:30:12 -0400
Received: from opersys.com ([64.40.108.71]:55821 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932345AbWIOXaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:30:11 -0400
Message-ID: <450B39DF.5000909@opersys.com>
Date: Fri, 15 Sep 2006 19:40:15 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>, "Jose R. Santos" <jrs@us.ibm.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu>	<Pine.LNX.4.64.0609152111030.6761@scrub.home>	<20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal>	<450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu> <y0m3basg2ig.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0m3basg2ig.fsf@ton.toronto.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank Ch. Eigler wrote:
> Let us design a static marker mechanism that can be coupled at run
> time either to a dynamic system such as systemtap, or by a specialized
> tracing system such as lttnng (!).  Then "markers" === "static
> instrumentation", for purposes of the kernel developer.  If the
> markers are lightweight enough, then a distribution kernel can afford
> keeping them compiled in.

I'm all for it.

Karim

