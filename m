Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVHZGbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVHZGbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVHZGbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:31:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46722 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932524AbVHZGbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:31:08 -0400
Date: Fri, 26 Aug 2005 08:31:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.13-rc7-rt1
Message-ID: <20050826063147.GD17783@elte.hu>
References: <20050825062651.GA26781@elte.hu> <1124984208.25139.0.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050825174515.GA31215@elte.hu> <1125005724.10901.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125005724.10901.5.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> On Thu, 2005-08-25 at 19:45 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Does anyone have x86_64 working in PREEMPT_RT ?
> > 
> > builds fine, but doesnt seem to boot at the moment. Havent investigated 
> > yet.
> 
> I tested an em64t , and it hung during boot .. But this patched fixed 
> it, does it do anything for you?

where does this patch come from (is it from upstream perhaps?), and what 
does it fix?

	Ingo
