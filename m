Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVKBHCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVKBHCM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVKBHCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:02:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53937 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932596AbVKBHCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:02:10 -0500
Date: Wed, 2 Nov 2005 08:02:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt1
Message-ID: <20051102070205.GA1348@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu> <1130876293.6178.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130876293.6178.6.camel@cmn3.stanford.edu>
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


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> The same kernel built for fc3 fails to boot in my Sony laptop. I see 
> this:
> 
> Kernel panic - not syncing: Attempted to kill init!

why did it panic - no indication of that?

	Ingo
