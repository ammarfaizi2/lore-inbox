Return-Path: <linux-kernel-owner+w=401wt.eu-S1754874AbWL1QFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbWL1QFF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbWL1QFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:05:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35657 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbWL1QFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:05:03 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 11:05:03 EST
Date: Thu, 28 Dec 2006 17:01:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: Re: [take29 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061228160137.GA19301@elte.hu>
References: <3154985aa0591036@2ka.mipt.ru> <11668927001365@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11668927001365@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> Generic event handling mechanism.

i see it covers alot of event sources, but i cannot see block IO 
notifications. Am i missing something?

	Ingo
