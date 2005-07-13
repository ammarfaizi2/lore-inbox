Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVGMTuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVGMTuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVGMTs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:48:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:970 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262403AbVGMTpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:45:40 -0400
Date: Wed, 13 Jul 2005 21:45:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050713194507.GA5493@elte.hu>
References: <200507091704.12368.s0348365@sms.ed.ac.uk> <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu> <20050711141622.GA17327@elte.hu> <20050711150711.GA19290@elte.hu> <1121198946.10580.13.camel@mindpipe> <Pine.LNX.4.63.0507121331480.9097@ghostwheel.llnl.gov> <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com> <Pine.LNX.4.63.0507131228280.6886@ghostwheel.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507131228280.6886@ghostwheel.llnl.gov>
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


* Chuck Harding <charding@llnl.gov> wrote:

> I missed getting -51-29 but just booted up -51-30 and all is well. 
> Thanks. Just out of curiosity, what was changed between -51-28, 29, 
> and 30?

-51-29 had new IO-APIC optimizations - and i reverted them in -51-30.

	Ingo
