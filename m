Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWIRAS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWIRAS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWIRAS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:18:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:38846 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965164AbWIRAS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:18:26 -0400
Date: Mon, 18 Sep 2006 02:17:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
In-Reply-To: <20060917234152.GA20374@elte.hu>
Message-ID: <Pine.LNX.4.64.0609180214320.6761@scrub.home>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
 <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home>
 <20060917150953.GB20225@elte.hu> <Pine.LNX.4.64.0609171816390.6761@scrub.home>
 <20060917234152.GA20374@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Sep 2006, Ingo Molnar wrote:

> Was it truly confusing to you what i said?

Not really, it's pretty clear, that you don't want me (or any other user 
of an arch, which doesn't support kprobes) cut some slack, so that I can 
make use of tracing. :-(

bye, Roman
