Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVKNSrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVKNSrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKNSrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:47:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:15822 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751227AbVKNSrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:47:03 -0500
Date: Mon, 14 Nov 2005 19:47:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Walker <dwalker@mvista.com>, trini@kernel.crashing.org,
       sdietrich@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rt11 Fill out default_simple_type
Message-ID: <20051114184709.GA2241@elte.hu>
References: <Pine.LNX.4.64.0511120639420.15898@dhcp153.mvista.com> <20051112144816.GA24942@elte.hu> <1131918975.32542.61.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131918975.32542.61.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 2005-11-12 at 15:48 +0100, Ingo Molnar wrote:
> > doesnt apply. Also, the set_type line has whitespace damage.
> > 
> > 	Ingo
> 
> I have integrated the initial patch from Tom Rini into the arm generic
> irq patch set.

this ptach too had whitespace damage (spaces instead of tabs) - merged 
it by hand.

	Ingo
