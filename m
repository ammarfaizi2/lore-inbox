Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbSKLRe4>; Tue, 12 Nov 2002 12:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266639AbSKLRe4>; Tue, 12 Nov 2002 12:34:56 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8964 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266631AbSKLRez>;
	Tue, 12 Nov 2002 12:34:55 -0500
Date: Tue, 12 Nov 2002 18:41:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, benh@kernel.crashing.org,
       Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021112174110.GA187@elf.ucw.cz>
References: <20021110115408.GA22068@atrey.karlin.mff.cuni.cz> <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com> <3205.1036707953@passion.cambridge.redhat.com> <7810.1036996696@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7810.1036996696@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  Yes... But how should "generic" battery info look like?
> > On apm you only know percentages and ETA left.
> > On acpi you know voltages, capacities and present rate.
> > On zaurus you only know voltages.
> > It will be quite hard to decide "one correct interface". It should
> > probably be called "/proc/power".
> 
> Battery info call returns a structure where some elements can be 'unknown'. 
> ACPI does it like that already, IIRC -- it's not mandatory to actually fill 
> in every field correctly. 

Would you care to suggest how battery info should look like?
								Pavel
-- 
When do you have heart between your knees?
