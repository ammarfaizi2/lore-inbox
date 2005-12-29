Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVL2Ium@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVL2Ium (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVL2Iul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:50:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:56236 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965065AbVL2Iuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:50:40 -0500
Date: Thu, 29 Dec 2005 09:50:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rc7-rt1
Message-ID: <20051229085026.GB31412@elte.hu>
References: <20051228172643.GA26741@elte.hu> <43B2D7A5.2080906@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B2D7A5.2080906@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> > i have released the 2.6.15-rc7-rt1 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > this release mainly includes fixes from Steven Rostedt, for various 
> > problems with -rc5-rt4 - while i'm over in mutex-land ;)
> > 
> > Please re-report any bugs that remain.
> 
> This one got all of the outstanding issues that I had run into thus far
                                            ^---fixed
> with previous patches. Compiled and booted on the old dual 933.

(just to clarify it to others)

	Ingo
