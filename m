Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935689AbWK1ImQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935689AbWK1ImQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935693AbWK1ImQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26811 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935689AbWK1ImP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:15 -0500
Date: Mon, 27 Nov 2006 13:47:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] futex: init error ckeck
Message-ID: <20061127124737.GA14308@elte.hu>
References: <20061127045624.GB1231@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127045624.GB1231@APFDCB5C>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50,DATE_IN_PAST_12_24 autolearn=no SpamAssassin version=3.0.3
	0.7 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4698]
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This patch checks register_filesystem() and kern_mount() return
> values.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

thanks.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
