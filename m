Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTLFLNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLFLNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:13:05 -0500
Received: from gprs147-238.eurotel.cz ([160.218.147.238]:17537 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264978AbTLFLND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:13:03 -0500
Date: Sat, 6 Dec 2003 12:14:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@kth.se>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: Tell user when ACPI is killing machine
Message-ID: <20031206111400.GA403@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720BFD@pdsmsx403.ccr.corp.intel.com> <20031204095454.GC6911@atrey.karlin.mff.cuni.cz> <1070532076.1645.42.camel@golgoth01> <20031204105621.GE11044@atrey.karlin.mff.cuni.cz> <yw1x8ylsltb3.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x8ylsltb3.fsf@kth.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I have a similar problem since test10 and test11 (2.4.23 is ok, test9 is
> >> ok too). ACPI reports bogus temperatures and powers the machine
> >> down.
> >
> >> If you have a patch that could fix that problem, I'm ready to try it and
> >> report success or failure ;)
> >
> > I have ugly workaround ("if temperature reported is > 200Celsius,
> > ignore it").
> 
> I'm just curious, are these (and other ACPI related) problems caused
> by bugs in Linux, or by hardware/firmware bugs?

Its hard to tell one from another without extensive debugging...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
