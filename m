Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUISVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUISVpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUISVpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:45:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61351 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264265AbUISVpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:45:13 -0400
Date: Sun, 19 Sep 2004 23:46:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040919214649.GA8443@elte.hu>
References: <200409192232.20139.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409192232.20139.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Hi Ingo,
> 
> things improved here after having applied
> swapspace-layout-improvements-2.6.9-rc1-bk12-A1. I'm happily running
> jackd and clients realtime now without any dropouts even under heavy
> swapping pressure. (Machine is a PIII@600MHz with 256MB RAM) Could you
> please include the swapspace-layout-improvements in the
> voluntary-preempt patches?

only if Andrew agrees that the patch has a chance for -mm inclusion and
possible upstream merging.

	Ingo
