Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTE1XXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTE1XXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:23:53 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:56243 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261669AbTE1XXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:23:53 -0400
Date: Thu, 29 May 2003 01:36:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Andrew Morton <akpm@digeo.com>, mikpe@csd.uu.se, miltonm@bga.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
Message-ID: <20030528233651.GA3880@elf.ucw.cz>
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net> <20030528111401.GB342@elf.ucw.cz> <16084.46712.707240.943086@gargle.gargle.HOWL> <20030528152827.5387e033.akpm@digeo.com> <20030528230534.GC2236@elf.ucw.cz> <1054163988.28296.1.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054163988.28296.1.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, we want system to be similar state it was when we suspended, to
> > prevent heisenbugs.
> 
> Heisenbugs? What's that in English? Sounds like it might be house
> bugs!

No, its after Heisenberg from quantum theory (and used incorrectly,
because it would be probably only difficult to debug, not depending on
debugger). See google, first link.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
