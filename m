Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270433AbTGWQdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTGWQdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:33:00 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:59619 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270443AbTGWQc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:32:56 -0400
Date: Wed, 23 Jul 2003 18:36:20 +0200
From: Dominik Brodowski <linux@brodo.de>
To: textshell@neutronstar.dyndns.org
Cc: davej@suse.de, linux-kernel@vger.kernel.org,
       Henrik Persson <nix@syndicalist.net>
Subject: Re: 2.6.0-test1: CPUFreq not working, can't find sysfs interface
Message-ID: <20030723163620.GC1870@brodo.de>
References: <20030720150243.GJ2331@neutronstar.dyndns.org> <200307201745.h6KHjcHt095999@sirius.nix.badanka.com> <20030720211246.GK2331@neutronstar.dyndns.org> <20030722120811.GD1160@brodo.de> <20030722141839.GD7517@neutronstar.dyndns.org> <20030722142353.GA1301@brodo.de> <20030722145352.GE7517@neutronstar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722145352.GE7517@neutronstar.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 04:53:52PM +0200, textshell@neutronstar.dyndns.org wrote:
> > Well, you could try using the PST which mostly matches your system except
> > the CPUID [PST #12, see below] -- if the values used are similar to the ones
> > Windows XP uses. But this might be risky!!!
> > 
> 
> I think you know a bit more about these matters than me, so please allow me this
> question:
> How much risk do you think that would be (with the usual 'you are not responible
> for any damages' stuff as usual) to just use that entry? At with the performance
> governour it is exactly the same as displayed as currently by x86info so that
> shouldn't be a problem. Do you think that lower frequencies and voltages can
> kill the processor? [I can cope with instabilities]

I really can't answer on that as I do neither know the hardware nor the BIOS
implementation well enough. Sorry.
BTW, it's no surprise that the x86info and cpufreq output are the same --
they use the same code. It'd be more interesting if Window$ uses the same
values [just mentioning it as you said PowerNow works on it, so....]

	Dominik
