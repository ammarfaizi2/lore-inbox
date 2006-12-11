Return-Path: <linux-kernel-owner+w=401wt.eu-S937479AbWLKTB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937479AbWLKTB3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937515AbWLKTB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:01:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50810 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937479AbWLKTB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:01:28 -0500
Date: Mon, 11 Dec 2006 19:59:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime: vanilla 2.6.19 with 2.6.19-rt11 patch doesn't boot
Message-ID: <20061211185959.GA26102@elte.hu>
References: <200612092001.01542.o.bock@fh-wolfenbuettel.de> <20061211134354.GB8219@elte.hu> <200612111742.30838.o.bock@fh-wolfenbuettel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612111742.30838.o.bock@fh-wolfenbuettel.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.4 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0270]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oliver Bock <o.bock@fh-wolfenbuettel.de> wrote:

> Hi Ingo,
> 
> Thanks for your reply. I tried -rt12 and could successfully boot my system.
> However, now I find the following during boot:
> 
> registering clocksource pit

these messages are fine - they are just for debugging.

	Ingo
