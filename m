Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVBKJFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVBKJFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVBKJFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:05:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39558 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262043AbVBKJBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:01:54 -0500
Date: Fri, 11 Feb 2005 10:01:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211090143.GC3980@elte.hu>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain> <20050211065753.GE15058@waste.org> <20050211075417.GA2287@elte.hu> <20050211082536.GF15058@waste.org> <20050211084843.GA3980@elte.hu> <20050211085832.GH15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211085832.GH15058@waste.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> Read more closely: there are two independent limits in the patch,
> RLIMIT_NICE and RLIMIT_RTPRIO. This lets us grant elevated nice
> without SCHED_FIFO.

ok, indeed.

	Ingo
