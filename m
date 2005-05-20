Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVETLgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVETLgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 07:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVETLgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 07:36:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40638 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261424AbVETLfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 07:35:53 -0400
Date: Fri, 20 May 2005 13:34:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: chen Shang <shangcs@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, rml@tech9.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Message-ID: <20050520113448.GA20486@elte.hu>
References: <855e4e4605051909561f47351@mail.gmail.com> <855e4e46050520001215be7cde@mail.gmail.com> <20050520094909.GA16923@elte.hu> <200505202040.51329.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505202040.51329.kernel@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> On Fri, 20 May 2005 19:49, Ingo Molnar wrote:
> > * chen Shang <shangcs@gmail.com> wrote:
> > > I minimized my patch and against to 2.6.12-rc4 this time, see below.
> >
> > looks good - i've done some small style/whitespace cleanups and renamed
> > prio to old_prio, patch against -rc4 below.
> 
> We should inline requeue_task as well.

yeah.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
