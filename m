Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVHEK7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVHEK7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVHEK7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:59:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45717 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262960AbVHEK67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:58:59 -0400
Date: Fri, 5 Aug 2005 12:59:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01]
Message-ID: <20050805105943.GA24994@elte.hu>
References: <1123186583.12009.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123186583.12009.32.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> This was my final version of the softlockup patch.  Do you have any 
> comments on it?  I wasn't sure if you were waiting for any more debate 
> on this patch or not.

ok, looks good - i've applied it and released the -52-14 PREEMPT_RT 
patch.

	Ingo
