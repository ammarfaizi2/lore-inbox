Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUIRNJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUIRNJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 09:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269491AbUIRNJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 09:09:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35820 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269464AbUIRNJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 09:09:36 -0400
Date: Sat, 18 Sep 2004 15:09:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040918130917.GA21081@elte.hu>
References: <414BCB5B.8020507@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414BCB5B.8020507@colorfullife.com>
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


* Manfred Spraul <manfred@colorfullife.com> wrote:

> Btw, Ingo forgot to mention sequence locks and percpu_counter as two
> high-scalability locking primitives.

yeah.

	Ingo
