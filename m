Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269137AbUIXUmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269137AbUIXUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUIXUkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:40:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22741 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269135AbUIXUj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:39:59 -0400
Date: Fri, 24 Sep 2004 22:22:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: Pavel Machek <pavel@ucw.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: problem with suspend and usb
Message-ID: <20040924202239.GB826@openzaurus.ucw.cz>
References: <1095685487.4294.14.camel@taz.graycell.biz> <20040922094844.GA9197@elf.ucw.cz> <1095870490.3809.3.camel@taz.graycell.biz> <20040922175058.GA14891@elf.ucw.cz> <1095981566.4339.16.camel@taz.graycell.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095981566.4339.16.camel@taz.graycell.biz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK, I inserted a printk between each line of acpi_power_off, I see
> set_cpus_allowed finished and then the pause, then after ~30s the
> poweroff, I never get to see the remaining printk.

Uh, can you quote lines that cause slowdown? This is probably best done
on acpi list, perhaps even go to bugzilla.kernel.org.

> By the way, is there a swsusp specific list?
> 

No. There's suspend2-specific list, but thats different codebase.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

