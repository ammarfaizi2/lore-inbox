Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932142AbWFDH5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWFDH5u (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 03:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFDH5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 03:57:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64710 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932142AbWFDH5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 03:57:49 -0400
Date: Sun, 4 Jun 2006 09:57:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060604075706.GB6248@elte.hu>
References: <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com> <20060601183836.d318950e.akpm@osdl.org> <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com> <20060602142009.GA10236@elte.hu> <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com> <20060602205332.GA5022@elte.hu> <986ed62e0606021533n4c8954eeifd71f97611a4c7f@mail.gmail.com> <20060603071301.GB19257@elte.hu> <20060603144121.GA3701@elte.hu> <986ed62e0606031410h48efd8b7i3a89e1c7ba1cd778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606031410h48efd8b7i3a89e1c7ba1cd778@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Barry K. Nathan <barryn@pobox.com> wrote:

> BTW, the latency_trace is close to 130K. Should I send it to you by 
> private mail instead of to the list? Or should I compress it and send 
> it as an attachment?

bzip -9 has a better than 1:20 compression ratio on latency traces, so 
the 130K should go down to ~6K - perfectly fine for attaching it. (that 
way others on lkml can take a look too)

	Ingo
