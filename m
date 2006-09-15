Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWIOWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWIOWfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWIOWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:35:23 -0400
Received: from opersys.com ([64.40.108.71]:64012 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932338AbWIOWfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:35:22 -0400
Message-ID: <450B2D00.9@opersys.com>
Date: Fri, 15 Sep 2006 18:45:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <20060915213213.GA12789@elte.hu> <20060915215852.GC18958@Krystal> <20060915221926.GD12789@elte.hu>
In-Reply-To: <20060915221926.GD12789@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> btw., an observation: that's 6 LTT architectures in 7 years, while 
> kprobes are now on 5 architectures in 2 years.

Actually much of ltt underwent a complete rewrite since Mathieu took
over maintainership. Let's, according to this email, Mathieu became
the maintainer in November 2005:
http://www.listserv.shafik.org/pipermail/ltt-dev/2005-November/001092.html

[ Karim takes out calculator and punches: 10/12 = 0.83 ]

So that's 7 architectures in 0.83 years, compared to 5 in 2 years.

Joke's on you pall.

Karim

