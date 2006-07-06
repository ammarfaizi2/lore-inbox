Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWGFIbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWGFIbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWGFIbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:31:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32209 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965039AbWGFIba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:31:30 -0400
Date: Thu, 6 Jul 2006 10:26:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, kmannth@gmail.com,
       linux-kernel@vger.kernel.org, tglx@linutronix.de,
       Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
Message-ID: <20060706082657.GA25677@elte.hu>
References: <20060705164457.60e6dbc2.akpm@osdl.org> <20060705164820.379a69ba.akpm@osdl.org> <a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com> <20060705172545.815872b6.akpm@osdl.org> <m1u05v2st3.fsf@ebiederm.dsl.xmission.com> <20060705225905.53e61ca0.akpm@osdl.org> <20060705233123.dcb0a10b.akpm@osdl.org> <m17j2r2od0.fsf@ebiederm.dsl.xmission.com> <20060706072529.GA12317@elte.hu> <m1psgj16ur.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psgj16ur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Still if we are doing this generically let's please put in a big fat 
> comment describing the situation, and maybe a compile warning, if 
> things get too big.

sure, feel free! :)

	Ingo
