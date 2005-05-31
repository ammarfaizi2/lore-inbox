Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVEaC0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEaC0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 22:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVEaC0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 22:26:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47056 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261739AbVEaC0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 22:26:33 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1117505204.22167.11.camel@mindpipe>
References: <m1br6zxm1b.fsf@muc.de>
	 <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
	 <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au>
	 <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au>
	 <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au>
	 <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au>
	 <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au>
	 <429BA27A.5010406@andrew.cmu.edu>  <1117505204.22167.11.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 30 May 2005 22:26:31 -0400
Message-Id: <1117506392.22232.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 22:06 -0400, Lee Revell wrote:
> No, *you're* the one misunderstanding.
> 
> Since *everything* is preemptible except a few known code paths whose
> execution times determine the maximum possible latency from interrupt to
> running the highest priority user process.

Sorry.  Should read:

*Everything* is preemptible except a few known code paths, whose
execution times determine the maximum possible latency from interrupt to
running the highest priority user process.

But, you'd know that, if you'd followed the development in the slightest
bit.

And, I think Ingo knows what "determinism" and "hard realtime" mean.  I
suggest you reread his posts.

Lee



