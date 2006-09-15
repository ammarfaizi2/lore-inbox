Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWIOVMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWIOVMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWIOVMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:12:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4008 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932271AbWIOVMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:12:39 -0400
Date: Fri, 15 Sep 2006 23:12:06 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060915200559.GB30459@elte.hu>
Message-ID: <Pine.LNX.4.64.0609152252540.6761@scrub.home>
References: <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
 <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org>
 <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home>
 <20060915200559.GB30459@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

> i'm also looking at it this way too: you already seem to be quite 
> reluctant to add kprobes to your architecture today. How reluctant would 
> you be tomorrow if you had static tracepoints, which would remove a fair 
> chunk of incentive to implement kprobes?

If I see that whole teams spend years to implement efficient dynamic 
tracing, do you really think that your "incentive" makes any difference?

byem Roman
