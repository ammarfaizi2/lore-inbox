Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUIHIXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUIHIXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIHIXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:23:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43749 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268954AbUIHIXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:23:36 -0400
Date: Wed, 8 Sep 2004 10:23:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040908082358.GB680@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <1094597710.16954.207.camel@krustophenia.net> <1094598822.16954.219.camel@krustophenia.net> <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK, could just someone with a P4 HT/SMP box hand me their working
> kernel .config file for me to try? That could be a good starting
> point, if not a plain baseline.

I'll try the latest VP kernel (-R9) on a P4/HT SMP box in a minute and
will send you a .config if it works. Could you also send me your
.config? 

	Ingo
