Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268111AbTBYRbW>; Tue, 25 Feb 2003 12:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbTBYRbW>; Tue, 25 Feb 2003 12:31:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50962 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268111AbTBYRbV>; Tue, 25 Feb 2003 12:31:21 -0500
Date: Tue, 25 Feb 2003 18:41:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com, andrew.grover@intel.com
Subject: Re: enable mem= to mark memory as acpi-reserved
Message-ID: <20030225174135.GC12028@atrey.karlin.mff.cuni.cz>
References: <20030220215638.GA18387@elf.ucw.cz> <20030225012823.7A5572C4DD@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225012823.7A5572C4DD@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This enables user to mark memory acpi-reserved; this is needed to get
> > acpi working on PaceBlade tablet (it has broken e820 tables). Second
> > diff makes printk output better aligned so it is possible to compare
> > RAM maps by eyes. Please apply,
> 
> Second is trivial, first isn't.  Suggest send to Andrew Grover.

Does it mean you will care about the second?

Okay, will push the first through Andrew.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
