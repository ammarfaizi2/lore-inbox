Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVAKJ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVAKJ17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVAKJ1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:27:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:51378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262644AbVAKJ1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:27:31 -0500
Date: Tue, 11 Jan 2005 01:27:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: tglx@linutronix.de, edjard@gmail.com, marcelo.tosatti@cyclades.com,
       mauriciolin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-Id: <20050111012708.06799806.akpm@osdl.org>
In-Reply-To: <20050111091919.GG26799@dualathlon.random>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	<20050110192012.GA18531@logos.cnet>
	<4d6522b9050110144017d0c075@mail.gmail.com>
	<20050110200514.GA18796@logos.cnet>
	<1105403747.17853.48.camel@tglx.tec.linutronix.de>
	<4d6522b90501101803523eea79@mail.gmail.com>
	<1105433093.17853.78.camel@tglx.tec.linutronix.de>
	<20050111085803.GF26799@dualathlon.random>
	<20050111010827.17dbaa52.akpm@osdl.org>
	<20050111091919.GG26799@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, Jan 11, 2005 at 01:08:27AM -0800, Andrew Morton wrote:
> > I have the original versions of these saved away but they generate a ton of
> > rejects now.  When you sync them up to Linus's current tree could you pleae
> > resend them all?
> 
> Can I trust the kernel CVS to be uptodate?

I don't know - I've never used it.  Others might know.
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ is always
up to date.  The problematic patches were merged three days ago though.

> I normally use it for such
> things but I'd prefer to be sure that I can trust it before risking
> wasting time (it has been unstable recently and I so I was working with
> patches in the meantime).

No huge rush - any time in the next week or two would suit.  I'd expect
-rc1 within the next week anwyay.

Thanks.
