Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVA1JMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVA1JMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVA1JMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:12:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17065 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261223AbVA1JMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:12:07 -0500
Date: Fri, 28 Jan 2005 10:11:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050128091143.GA6199@elte.hu>
References: <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <20050128080802.GA2860@elte.hu> <871xc62bot.fsf@sulphur.joq.us> <20050128084049.GA5004@elte.hu> <87vf9i0vx3.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vf9i0vx3.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> > thus after a couple of years we'd end up with lots of desktop apps
> > running as SCHED_FIFO, and latency would go down the drain again.
> 
> I wonder how Mac OS X and Windows deal with this priority escalation
> problem?  Is it real or only theoretical?

no idea. Anyone with MacOSX/Windows application writing experience? :-|

	Ingo
