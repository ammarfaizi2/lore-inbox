Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWINVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWINVap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWINVap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:30:45 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42654 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751208AbWINVao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:30:44 -0400
Date: Thu, 14 Sep 2006 23:30:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <1158268113.17467.38.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.64.0609142324181.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
  <Pine.LNX.4.64.0609141537120.6762@scrub.home>  <20060914135548.GA24393@elte.hu>
  <Pine.LNX.4.64.0609141623570.6761@scrub.home>  <20060914171320.GB1105@elte.hu>
  <Pine.LNX.4.64.0609141935080.6761@scrub.home>  <20060914181557.GA22469@elte.hu>
  <Pine.LNX.4.64.0609142038570.6761@scrub.home>  <20060914202452.GA9252@elte.hu>
  <Pine.LNX.4.64.0609142248360.6761@scrub.home>
 <1158268113.17467.38.camel@c-67-180-230-165.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Daniel Walker wrote:

> > Ingo, so far you have made not a single argument why they can't coexist 
> > except for your personal dislike.
> 
> Not to put to fine a point on it, but I think there's not a small number
> of us that "prefer" the best solution.

You can have it.
OTOH I would also like to know what's going in my m68k kernel without 
having to implement some rather complex infrastructure, which I don't need 
otherwise. There hasn't been a single argument so far, why we can't have 
both.

bye, Roman
