Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVKCGxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVKCGxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKCGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:53:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:29088 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751140AbVKCGxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:53:19 -0500
Date: Thu, 3 Nov 2005 07:53:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt4:  __get_nsec_offset() false positives
Message-ID: <20051103065309.GA13037@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu> <1130967703.27168.503.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130967703.27168.503.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> I'll write up a paranoid debug patch that provides similar checks for 
> both cases and include it in my patch set so you don't have to keep 
> forward porting your own versions.

ok. I'll drop mine for the time being.

	Ingo
