Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUADRsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUADRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:48:12 -0500
Received: from ms-smtp-01-qfe0.nyroc.rr.com ([24.24.2.55]:1200 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265809AbUADRsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:48:10 -0500
Date: Sun, 4 Jan 2004 12:48:05 -0500
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: gaim problems in 2.6.0
Message-ID: <20040104174805.GA2120@andromeda>
References: <20040104172535.GA322@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104172535.GA322@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running gaim .74 on 2.6.0, with
        Driver      "ati"
        BoardName   "Rage 128 Mobility LF"
        BusID       "PCI:1:0:0"
        Option     "AGPMode"       "2".
No problems here.
(Linux andromeda 2.6.0 #70 Fri Jan 2 17:29:30 EST 2004 i686 GNU/Linux,
Dell Insp 4k).

Justin

On Sun, Jan 04, 2004 at 06:25:36PM +0100, Pavel Machek wrote:
> Hi!
> 
> I'm having bad problems with gaim... When I run gaim, my machine tends
> to freeze hard (no blinking leds). I'm running vesafb -> that should
> rule out X problems. Machine is rather strange pre-production athlon64
> noteook, but I'm running 32-bit (on 32-bit kernel), and I can run gaim
> under 2.4.X kernel.
> 
> [Ugh, I was running with kgdb, but I recall same problem before, too.]
> 
> Does anyone have similar problem?
> 								Pavel
> -- 
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
