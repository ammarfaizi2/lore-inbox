Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWI0Iis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWI0Iis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWI0Iir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:38:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37523 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932131AbWI0Iir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:38:47 -0400
Date: Wed, 27 Sep 2006 10:31:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Kacur <jkacur@ca.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove extra extern in 2.6.18-rt3
Message-ID: <20060927083100.GB12149@elte.hu>
References: <1159283693.21437.5.camel@tycho.torolab.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159283693.21437.5.camel@tycho.torolab.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4965]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Kacur <jkacur@ca.ibm.com> wrote:

> Remove a duplicate line.
> Signed-off-by: "John Kacur" <jkacur@rogers.com>

thx, applied.

	Ingo
