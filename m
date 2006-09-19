Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWISN0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWISN0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWISN0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:26:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53455 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751285AbWISN0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:26:38 -0400
Date: Tue, 19 Sep 2006 15:25:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracing - consensus building insteat of dogfights
In-Reply-To: <20060919125801.GA12815@infradead.org>
Message-ID: <Pine.LNX.4.64.0609191517300.6761@scrub.home>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
 <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy>
 <20060917230623.GD8791@elte.hu> <Pine.LNX.4.64.0609180136340.6761@scrub.home>
 <20060919125801.GA12815@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 19 Sep 2006, Christoph Hellwig wrote:

>   *) so far everyone but Roman seems to agree we want to support dynamic
>      tracing as an integral part of the tracing framework

Actually I don't disagree at all, I'm sorry if I have been so easy to 
misunderstand. All I'm asking for is to make static tracing possible if 
reasonably possible. I know that pure static tracing will always be second 
choice, but if we can _reasonably_ support it, why shouldn't we do it?

bye, Roman
