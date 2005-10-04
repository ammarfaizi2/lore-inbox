Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVJDO05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVJDO05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJDO04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:26:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18356 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932494AbVJDO0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:26:55 -0400
Date: Tue, 4 Oct 2005 16:27:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004142718.GA3195@elte.hu>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Oct 2005, Ingo Molnar wrote:
> 
> >
> > ugh. uploaded -rt6.
> >
> > 	Ingo
> 
> Hmm Ingo,
> 
> Looks like -rt6 got rid of all the _nort defines, but it's still used 
> throughout the kernel.

yeah, -rt7 should fix this.

	Ingo
