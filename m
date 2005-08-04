Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVHDPQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVHDPQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVHDPOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:14:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23756 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261958AbVHDPOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:14:01 -0400
Date: Thu, 4 Aug 2005 17:14:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: wakeup race checking for RT
Message-ID: <20050804151434.GA20461@elte.hu>
References: <1122932189.4623.25.camel@dhcp153.mvista.com> <20050804144244.GB15447@elte.hu> <1123167498.9011.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123167498.9011.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
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

> On Thu, 2005-08-04 at 16:42 +0200, Ingo Molnar wrote:
> 
> > I've applied your patch, and have released the -52-13 PREEMPT_RT 
> > patchset. [ But please be more careful with the coding style next time, 
> > see below the number of fixups i had to do relative to your patch 
> > (whitespaces, line length, code structure format, etc.). ]
> 
> 	I do quite a bit of review before releasing, but it's hard to 
> catch that stuff unless you didn't write it. (or you read it 
> backwards)

no problem - it's mostly a matter of experience. After 10+ years of 
Linux kernel hacking experience you'll notice these bugs in your own 
code too. (or better, you will write perfect-style code straight away :)

	Ingo
