Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUGKJRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUGKJRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUGKJRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:17:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11441 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266520AbUGKJRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:17:07 -0400
Date: Sun, 11 Jul 2004 11:18:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711091807.GA16087@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <20040710151455.GA29140@devserv.devel.redhat.com> <40F008B0.8020702@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F008B0.8020702@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> >>I've conducted some of the old fashioned Benno's latency test on this 
> >
> >
> >is that the test which skews with irq's disabled ? (eg uses normal
> >interrupts and not nmi's for it's initial time inrq)
> 
> It probably is; in which case all these results would be useless, no?
> 
> http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz

did you run latencytest as root?

	Ingo
