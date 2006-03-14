Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWCNICo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWCNICo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbWCNICn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:02:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:1187 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750990AbWCNICn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:02:43 -0500
Date: Tue, 14 Mar 2006 09:00:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060314080026.GC13662@elte.hu>
References: <20060312220218.GA3469@elte.hu> <1142302930.27125.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142302930.27125.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I noticed that if I have latency tracing on and don't have 
> early_printk, it also won't compile.  Here's a patch to solve that 
> too.

thanks, applied.

	Ingo
