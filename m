Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVAUVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVAUVZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVAUVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:24:23 -0500
Received: from fsmlabs.com ([168.103.115.128]:59070 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262524AbVAUVXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:23:51 -0500
Date: Fri, 21 Jan 2005 14:23:01 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
cc: Tony Lindgren <tony@atomide.com>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
In-Reply-To: <20050121185432.GC19551@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0501211209550.18199@montezuma.fsmlabs.com>
References: <20050119000556.GB14749@atomide.com>
 <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com>
 <20050121174831.GE14554@atomide.com> <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
 <20050121185432.GC19551@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Pavel Machek wrote:

> > > > This doesn't seem to cover the local APIC timer, what do you do about the 
> > > > 1kHz tick which it's programmed to do?
> > > 
> > > Sorry for the delay in replaying. Thanks for pointing that out, I
> > > don't know yet what to do with the local APIC timer. Have to look at
> > > more.
> > 
> > Pavel does your test system have a Local APIC? If so that may also explain 
> > why you didn't see a difference.
> 
> My systems do have APICs, but I prefer them disabled :-).

May i ask why? ;)
