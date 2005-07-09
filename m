Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVGIPAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVGIPAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 11:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVGIPAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 11:00:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38352 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261496AbVGIPAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 11:00:08 -0400
Date: Sat, 9 Jul 2005 16:59:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.12-RT-V0.7.51-18: RT task yield()-ing!
Message-ID: <20050709145959.GA11523@elte.hu>
References: <1120919366.14404.5.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120919366.14404.5.camel@twins>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Hi Ingo,
> 
> I got the following BUG while playing a nice tune with xmms. Shortly 
> after the BUG the machine froze hard and I had to reach over and press 
> the reset button.
> 
> PS. there is a simple compile error in 51-18 when 
> CONFIG_DEBUG_STACKOVERFLOW is undefined.

thx - fixed them in -51-21.

	Ingo
