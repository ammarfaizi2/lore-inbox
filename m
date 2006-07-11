Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWGKQMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWGKQMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWGKQMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:12:44 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:64455
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1751149AbWGKQMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:12:43 -0400
Date: Tue, 11 Jul 2006 18:13:12 +0200
From: andrea@cpushare.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060711161311.GK7192@opteron.random>
References: <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random> <1152633242.3128.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152633242.3128.81.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:54:02PM +0200, Arjan van de Ven wrote:
> Ehm I wasn't aware all linux vendors in the world owe that to you, or
> that you own their kernel configuration

I perfectly know nobody owes anything to me, I said I didn't expect it
because it sounds very weird having to take an anti-fedora position in a
project like CPUShare. Hope you didn't get it wrong because I'd be sad
having opened this whole topic if you were wrong and SECCOMP was
actually enabled in fedora.

> I have no idea; I don't work there. Also I checked Fedora, not RHEL, and
> Fedora is done by the Fedora project, not by Red Hat the company. If you
> want to ask them to enable it, you should do so on the fedora-devel
> mailing list

Aren't Ingo and Alan Fedora? If they ask N in the main kernel, and they
already set it to N in fedora I'm unsure what I should discuss further
with them.

And most of this whole thread is grossly offtopic, I'm amazed nobody
complained yet about the questions they ask about cpushare legal details
on this list, I guess it was entertaining enough for people not to
complain just yet.

I won't post more emails from my part... hope it helps reducing the
noise.
