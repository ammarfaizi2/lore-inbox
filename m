Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUB0XeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 18:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUB0XeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 18:34:11 -0500
Received: from gprs158-32.eurotel.cz ([160.218.158.32]:28288 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263193AbUB0XeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 18:34:09 -0500
Date: Sat, 28 Feb 2004 00:33:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Piet Delaney <piet@www.piet.net>
Cc: George Anzinger <george@mvista.com>, Andi Kleen <ak@suse.de>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040227233355.GA425@elf.ucw.cz>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel> <p73n07ykyop.fsf@verdi.suse.de> <200402052320.04393.amitkale@emsyssoft.com> <20040206032054.3fd7db8d.ak@suse.de> <40295388.5080901@mvista.com> <1077916151.3291.133.camel@www.piet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077916151.3291.133.camel@www.piet.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I thought I'd poke around an AMD64 with etherbased kgdb on 2.6.*.
> I just picked up a used AMD64 K8D Master-F MS-9131 and thought I'd
> install Fedora Core 1 test1 and the latest kernel from kernel.org.
> 
> It Might be interesting to try out a SuSE release also, I was wondering
> if 9.0 from linuxiso.org might be best.
> 
> Last I worked with your kgdb patch for 2.6 Andrew's mm patch had the
> latest code; Is that still the case?

I think that latest is the code in kgdb.sf.net cvs. Code in -mm tree
is "known good".
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
