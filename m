Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVAUSy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVAUSy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVAUSy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:54:58 -0500
Received: from gprs215-210.eurotel.cz ([160.218.215.210]:41958 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262462AbVAUSyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:54:54 -0500
Date: Fri, 21 Jan 2005 19:54:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050121185432.GC19551@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com> <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com> <20050121174831.GE14554@atomide.com> <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This doesn't seem to cover the local APIC timer, what do you do about the 
> > > 1kHz tick which it's programmed to do?
> > 
> > Sorry for the delay in replaying. Thanks for pointing that out, I
> > don't know yet what to do with the local APIC timer. Have to look at
> > more.
> 
> Pavel does your test system have a Local APIC? If so that may also explain 
> why you didn't see a difference.

My systems do have APICs, but I prefer them disabled :-).
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
