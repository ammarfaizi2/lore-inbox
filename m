Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUJOLsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUJOLsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJOLr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:47:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64664 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267683AbUJOLrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:47:53 -0400
Date: Fri, 15 Oct 2004 13:49:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Mateusz.Blaszczyk@nask.pl, rml@tech9.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, 2.6.9-rc4-mm1] fix oops in sched_setscheduler
Message-ID: <20041015114918.GB22823@elte.hu>
References: <Pine.GSO.4.58.0410150833330.9897@boromir> <20041015090336.GA14362@elte.hu> <20041015105633.GG5607@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015105633.GG5607@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> I agree this is needed. I left the feature undisturbed from its state
> in mainline, though perhaps I should have looked further into it.

but i think it was you who sent the original preempt=schedule patch to
akpm, which was the one that got merged into mainline later on :-) I am
sure it worked fine when i sent it out, so it must have gotted mismerged
somewhere inbetween. (not that it matters much.)

	Ingo
