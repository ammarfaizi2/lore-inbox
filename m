Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVJROtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVJROtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVJROtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:49:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45752 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750717AbVJROtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:49:25 -0400
Date: Tue, 18 Oct 2005 16:49:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051018144907.GA5877@elte.hu>
References: <20051017160536.GA2107@elte.hu> <1129576885.4720.3.camel@cmn3.stanford.edu> <1129599029.10429.1.camel@cmn3.stanford.edu> <20051018072844.GB21915@elte.hu> <4355029E.9050809@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4355029E.9050809@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo,
> 
> The attached patch is necessary to build -rt8 if high res timers are 
> not enabled.

thanks - applied.

	Ingo
