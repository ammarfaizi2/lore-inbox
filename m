Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVAKJTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVAKJTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVAKJTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:19:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:24389
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262632AbVAKJTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:19:04 -0500
Date: Tue, 11 Jan 2005 10:19:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, edjard@gmail.com, marcelo.tosatti@cyclades.com,
       mauriciolin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-ID: <20050111091919.GG26799@dualathlon.random>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de> <4d6522b90501101803523eea79@mail.gmail.com> <1105433093.17853.78.camel@tglx.tec.linutronix.de> <20050111085803.GF26799@dualathlon.random> <20050111010827.17dbaa52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111010827.17dbaa52.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:08:27AM -0800, Andrew Morton wrote:
> I have the original versions of these saved away but they generate a ton of
> rejects now.  When you sync them up to Linus's current tree could you pleae
> resend them all?

Can I trust the kernel CVS to be uptodate? I normally use it for such
things but I'd prefer to be sure that I can trust it before risking
wasting time (it has been unstable recently and I so I was working with
patches in the meantime).
