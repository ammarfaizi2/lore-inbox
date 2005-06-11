Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVFKHQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVFKHQU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 03:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFKHQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 03:16:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59095 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261622AbVFKHQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:16:18 -0400
Date: Sat, 11 Jun 2005 09:08:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611070845.GA4609@elte.hu>
References: <42AA6A6B.5040907@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AA6A6B.5040907@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


could you send me the .config you used for the PREEMPT_RT tests? Also, 
you used -47-08, which was well prior the current round of performance 
improvements, so you might want to re-run with something like -48-06 or 
better.

	Ingo
