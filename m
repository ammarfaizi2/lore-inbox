Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269633AbUJLLmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbUJLLmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269624AbUJLLmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:42:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51903 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269648AbUJLLmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:42:36 -0400
Date: Tue, 12 Oct 2004 13:43:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041012114352.GA32206@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <416B54BA.9050606@cybsft.com> <20041012060213.GD1479@elte.hu> <416BBB34.3030107@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416BBB34.3030107@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >(which symbol was this?)
> 
> WARNING: 
> /lib/modules/2.6.9-rc4-mm1-VP-T5-RT/kernel/drivers/net/ppp_synctty.ko 
> needs unknown symbol _mutex_trylock_bh

thx - fix will be in -T7.

	Ingo
