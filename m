Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbUJYNjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbUJYNjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbUJYNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:36:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20697 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261800AbUJYNe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:34:26 -0400
Date: Mon, 25 Oct 2004 15:35:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025133517.GA10740@elte.hu>
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com> <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu> <20041025153940.1de340b4@mango.fruits.de> <20041025154855.21447333@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025154855.21447333@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> [snip]
> 
> i forgot to mention these were from the same session as the previous
> one. also i think i missed the first ones, so the reports in this mail
> are probably useless(?).

i think the futex assert is a separate problem not triggered by the
module.c warnings.

	Ingo
