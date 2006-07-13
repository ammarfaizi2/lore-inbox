Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWGMFPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWGMFPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGMFPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:15:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbWGMFPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:15:54 -0400
Date: Wed, 12 Jul 2006 22:12:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
In-Reply-To: <20060713044053.GE9102@opteron.random>
Message-ID: <Pine.LNX.4.64.0607122208330.5623@g5.osdl.org>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de>
 <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de>
 <20060713030402.GC9102@opteron.random> <Pine.LNX.4.64.0607122010060.5623@g5.osdl.org>
 <20060713044053.GE9102@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jul 2006, Andrea Arcangeli wrote:
> 
> But there may be some users only using alsa to play mp3, so it's not
> so different (certainly I agree if it would be nice if there would be
> more users since it can solve the codec decompression exploits).

You aren't even listening.

> If what you don't like is the API and you want to change it (like
> replacing the /proc interface with a syscall or a prctl) that's fine
> with me though.

This has NOTHING to do with the API.

You're just in denial, and don't even listen to what people say. It also 
has nothing to do with cpufreq, which again is a case of _some_ uses may 
be patented, but not "_the_ use"

I just stated that if other interfaces don't have the problem that their 
only use is patent-protected, then other interfaces are clearly better 
alternatives. IF they have users at all.

			Linus
