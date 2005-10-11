Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbVJKLUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVJKLUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVJKLUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:20:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29406 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751453AbVJKLUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:20:09 -0400
Date: Tue, 11 Oct 2005 13:20:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
Message-ID: <20051011112043.GB15995@elte.hu>
References: <1128724690.17981.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128724690.17981.57.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Something appears to have disabled IRQs for 657 usecs.

how hard is it to reproduce this latency?

	Ingo
