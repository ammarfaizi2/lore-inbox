Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUIHIv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUIHIv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIHIv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:51:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41857 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268950AbUIHIvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:51:07 -0400
Date: Wed, 8 Sep 2004 10:52:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040908085237.GA4375@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <1094597710.16954.207.camel@krustophenia.net> <1094598822.16954.219.camel@krustophenia.net> <32930.192.168.1.5.1094601493.squirrel@192.168.1.5> <20040908082358.GB680@elte.hu> <13164.195.245.190.93.1094633206.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13164.195.245.190.93.1094633206.squirrel@195.245.190.93>
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

> Few moments ago, Tim Savannah was kind enough to send me it's working
> .config for 2.6.9-rc1-bk13 with ck patch and voluntary preempt R6. At
> first glance it seems that he takes the monolithic approach while I
> prefer all-modular. The other main difference is that he has HIGHMEM
> disabled, while I'm on HIGHMEM(4GB) 'coz my machine has 1GB of RAM
> :)

mine is HIGHMEM4G too.

	Ingo
