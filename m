Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWI0NRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWI0NRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWI0NRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:17:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12740 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751156AbWI0NRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:17:20 -0400
Date: Wed, 27 Sep 2006 15:09:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@third-harmonic.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rt4
Message-ID: <20060927130908.GA24376@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <45134829.9040708@third-harmonic.com> <20060922063621.GA1283@xi.wantstofly.org> <20060922115636.GA12212@elte.hu> <451A7842.4090201@third-harmonic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451A7842.4090201@third-harmonic.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john cooper <john.cooper@third-harmonic.com> wrote:

> >ok, i've added this no-4M-limit patch to -rt. John, does that solve 
> >your problem?
> 
> A few of us hit a snag in Lennert's original patch.  He has a fix 
> which addresses this, attached.

ok, applied.

	Ingo
