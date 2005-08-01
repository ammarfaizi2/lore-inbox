Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVHAVSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVHAVSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVHAVRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:17:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17829 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261235AbVHAVOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:14:47 -0400
Date: Mon, 1 Aug 2005 23:15:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050801211525.GA22315@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122920564.6759.15.camel@localhost.localdomain> <20050801205208.GA20731@elte.hu> <1122930581.4623.10.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122930581.4623.10.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > here's the patch below. Could you try to revert it?
> 
> You guys want me to always CC in the future?

well if it's somewhat larger than a trivial fix then it would definitely 
be useful to always Cc: lkml. Trivial fixes can go to lkml too, just in 
case i dont upload fast enough and someone else wants the fix too.  
Generally, Cc:-ing the mailing list also puts less of a burden on me, 
because others might find flaws in patches i dont spot right away.

	Ingo
