Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWGDKht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWGDKht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGDKht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:37:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4771 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932121AbWGDKht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:37:49 -0400
Date: Tue, 4 Jul 2006 12:33:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Minor cleanup to lockdep.c
Message-ID: <20060704103314.GA31568@elte.hu>
References: <200607041234.30350.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607041234.30350.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5020]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> - Use printk formatting for indentation
> - Don't leave NTFS in the default event filter
> 
> Signed-off-by: Andi Kleen <ak@suse.de>

thanks!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
