Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSIXRl1>; Tue, 24 Sep 2002 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSIXRlC>; Tue, 24 Sep 2002 13:41:02 -0400
Received: from dsl-213-023-039-208.arcor-ip.net ([213.23.39.208]:1468 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261767AbSIXRhu>;
	Tue, 24 Sep 2002 13:37:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Tue, 24 Sep 2002 19:39:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <20020923120400.A15452@acpi.pdx.osdl.net> <20020923.135447.24672280.davem@redhat.com> <20020924095456.A17658@acpi.pdx.osdl.net>
In-Reply-To: <20020924095456.A17658@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ttf4-0003iY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 18:54, Dave Olien wrote:
> I haven't been ignoring the discussion.  Just thinking it over.
> I was going to dig out an old PCI spec last night, but got involved
> with other things.  I wanted to review how 64-bit PCI and 32-bit PCI busses
> handle 32 and 64-bit writes from the processor.
> 
> I don't have a spec for these controllers.  IBM is selling Mylex
> to LSI logic, so "All contracts, NDA's and agreements are on hold
> until a transition to lsi is complete"  

Note: I will sign an NDA to get the specs for this card (family) but I
would much prefer that somebody gets a clue and just releases the spec.
Frankly, this board needs all the help it can get, based on comparative
performance.  Keeping the spec secret is just a brilliant way to ensure
it will die, and thus be worth $0.00 to the purchaser.

(I sincerely hope somebody in the DAC960 food chain notices this
comment, or somebody forwards it to one of the aforementioned: give
the world the spec and we will reciprocate by making the thing go as
fast as theoretically possible.)

Daniel
