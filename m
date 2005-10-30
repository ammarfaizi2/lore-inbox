Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVJ3RTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVJ3RTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVJ3RTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:19:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:64695 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932192AbVJ3RTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:19:03 -0500
Date: Sun, 30 Oct 2005 18:19:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt1
Message-ID: <20051030171909.GA17359@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu> <4364DFA5.3000109@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4364DFA5.3000109@cybsft.com>
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

> >  - rtc histogram fixes (K.R. Foley)
> 
> Actually it doesn't look like these made it into the patch. :)

they were there, but they apparently went missing during a rebase. I've 
re-added them and they should show up in -rt2.

	Ingo
