Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVDBUgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDBUgF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDBUgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:36:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12189 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261264AbVDBUgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:36:02 -0500
Date: Sat, 2 Apr 2005 22:35:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050402203550.GB16230@elte.hu>
References: <20050325145908.GA7146@elte.hu> <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com> <200504011834.22600.gene.heskett@verizon.net> <20050402051254.GA23786@elte.hu> <1112470675.27149.14.camel@localhost.localdomain> <1112472372.27149.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112472372.27149.23.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2005-04-02 at 14:37 -0500, Steven Rostedt wrote:
> 
> > Here's the bug I get:
> > 
> 
> FYI
> 
> For kicks I ran this on 2.6.11-rc2-RT-V0.7.36-02 (I still had it as a 
> Grub option), and the system just locked up hard.  I just was curious 
> if this was from a different change. But at least in the latest it 
> shows output, and not just a hard lockup.
> 
> Oh, the bug report was running kernel 2.6.12-rc1-RT-V0.7.43-06.

ok, so it's not the recent NFS changes.

	Ingo
