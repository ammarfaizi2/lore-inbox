Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132023AbRCVNt2>; Thu, 22 Mar 2001 08:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132024AbRCVNtL>; Thu, 22 Mar 2001 08:49:11 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:2362 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132023AbRCVNsz>; Thu, 22 Mar 2001 08:48:55 -0500
Date: Thu, 22 Mar 2001 08:48:09 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SMP on assym. x86
In-Reply-To: <20010322130029.A4212@garloff.casa-etp.nl>
Message-ID: <Pine.LNX.4.10.10103220842470.12746-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > handle the situation with 2 different CPUs (AMP = Assymmetric
> > > > multiprocessing ;-) correctly.
> > > 
> > > "correctly".  Intel doesn't support this (mis)configuration:
> > > especially with different steppings, not to mention models.
> 
> I wouldn't call it misconfiguration, just because it's a bit more difficult
> to handle.

again, I *would* call it misconfiguration.  intel says explicitly that 
they don't support mixing model/family parts.  and they only test
same-clock combinations (but do support mixed steppings.)  just so people
don't get the impression that random, different CPUs are a sure thing...

