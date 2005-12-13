Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVLMIJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVLMIJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVLMIJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:09:19 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:26071 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751333AbVLMIJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:09:18 -0500
Date: Tue, 13 Dec 2005 09:08:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot build with !PREEMPT_RT)
Message-ID: <20051213080827.GA10088@elte.hu>
References: <20051129072922.GA21696@elte.hu> <20051129093231.GA5028@elte.hu> <1134090316.11053.3.camel@mindpipe> <1134174330.18432.46.camel@mindpipe> <1134409469.15074.1.camel@mindpipe> <1134424143.24145.6.camel@localhost.localdomain> <1134425688.17058.5.camel@mindpipe> <1134426179.24145.15.camel@localhost.localdomain> <1134426711.17058.10.camel@mindpipe> <1134444480.24145.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134444480.24145.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Here Lee,
> 
> I got it to compile, but I haven't yet tried to boot it.  As a matter 
> of fact, I haven't booted any 2.6.15-rc5-rt1 on any of my machines.  I 
> must trust Ingo too much, since I started porting my kernel to his 
> before testing it to see if it works without my changes.  Oh well, I 
> know what to do tomorrow.

thanks, i have applied most of this patch.

	Ingo
