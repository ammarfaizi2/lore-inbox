Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbRGJTUH>; Tue, 10 Jul 2001 15:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267108AbRGJTT5>; Tue, 10 Jul 2001 15:19:57 -0400
Received: from [194.213.32.142] ([194.213.32.142]:8452 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267106AbRGJTTq>;
	Tue, 10 Jul 2001 15:19:46 -0400
Message-ID: <20010710004449.B557@bug.ucw.cz>
Date: Tue, 10 Jul 2001 00:44:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org,
        acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: ACPI fundamental locking problems
In-Reply-To: <3B421AEA.8809D11C@mandrakesoft.com> <E15HW0o-0008FJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15HW0o-0008FJ-00@the-village.bc.nu>; from Alan Cox on Tue, Jul 03, 2001 at 08:39:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The difference with ACPI is that vendors can write code that is executed
> > in the kernel's context (instead of what you can consider the BIOS's
> > context).  That is a whole new can of worms.
> 
> For security reasons alone we need to ensure ACPI can be firmly in the off
> position. Executing US written binary code in the Linux kernel will not be
> acceptable to european corporations, non US military bodies and most 
> Governments. They'd hate the US to get prior warning of say protestors
> walking into their top secret menwith hill base playing the mission impossible
> theme tune then chaining themselves to things..
> 
> And if the NSA wants the US goverment to execute binary only chinese bios code
> on all their critical systems I am sure people will be happy.

...but I still would be happier if there was no AML interpretation...
								Pavel 
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
