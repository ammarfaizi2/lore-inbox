Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292948AbSBQMnC>; Sun, 17 Feb 2002 07:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292949AbSBQMmw>; Sun, 17 Feb 2002 07:42:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62728 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292948AbSBQMml>; Sun, 17 Feb 2002 07:42:41 -0500
Date: Sun, 17 Feb 2002 07:41:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Staudinger <mark@staudinger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 on Pentium?
In-Reply-To: <200202141526.g1EFQfjC035904@mark.staudinger.net>
Message-ID: <Pine.LNX.3.96.1020217073839.30060F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Mark Staudinger wrote:

> Is there any known problem with running kernel 2.4.12 on a P54/P55 CPU?  I'm
> unable to get a 2.4.12 kernel to boot on a pentium class machine, regardless
> of what I choose for the "Processor Family" support in the config.
> 
> A similar (if not identical) config of kernel 2.4.5 works just fine, even if
> compiled for 686/Celeron processor family.
> 
> The machine reboots during the "loading kernel...." phase and before the 
> "Uncompressing kernel" boot message.

I don't believe there's a problem here, I've run 2.4.5, 2.4.10, 2.4.13,
and 2.4.17 on both P5 and P5C (yes/no MMX) without problems. Sounds more
like a boot loader problem, does your LILO need 'linear' or something?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

