Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281834AbRLBVah>; Sun, 2 Dec 2001 16:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281811AbRLBVa1>; Sun, 2 Dec 2001 16:30:27 -0500
Received: from ns.suse.de ([213.95.15.193]:12554 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281797AbRLBVaS>;
	Sun, 2 Dec 2001 16:30:18 -0500
Date: Sun, 2 Dec 2001 22:30:16 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Henning Schmiedehausen <hps@intermeta.de>,
        Alexander Viro <viro@math.psu.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <E16Ae9Y-0004c9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112022225560.26183-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Alan Cox wrote:

> What would be much much more constructive isnt quite a hall of shame - its
> to build a set of pages that take problem drivers and quote chunks of them
> with an explanation of _why_ it is wrong, what should be used instead and
> possible the "after" code if it also gets cleaned up.

I planned to do something like this for the kernel-janitor project.
The janitor todo-list is aparently too terse for some people, and
having a perl script to point out problems wasn't enough. Maybe having the
script point to a webpage explaining /why/ xxxx needs changing would be
more useful.

The current TODO list there goes halfway toward this, but needs
expanding, more explanations etc.. Any contributions more than
welcomed.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

