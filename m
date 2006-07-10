Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWGJQyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWGJQyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWGJQyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:54:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43016 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422698AbWGJQyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:54:31 -0400
Date: Mon, 10 Jul 2006 18:54:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Pavel Machek <pavel@suse.cz>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.16.y series
Message-ID: <20060710165429.GB13938@stusta.de>
References: <20060706222553.GA2946@kroah.com> <20060707105407.GA1654@elf.ucw.cz> <44AE558D.9000906@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AE558D.9000906@linuxtv.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 08:37:33AM -0400, Michael Krufky wrote:
> Pavel Machek wrote:
> 
> >Is it still okay to submit patches for 2.6.16-stable? I guess "dirty
> >buffers flushing broken after resume" may count...
> >								Pavel
> > 
> >
> I was under the impression that 2.6.16.y was staying open for a much 
> longer time, as per Adrian's "2.6.16 long living kernel" announcement a 
> short while back.
> 
> I just assumed that the Greg and Chris were handling it until 2.6.18 
> gets released, and then Adrian takes over 2.6.16.y while the [stable] 
> team moves on to 2.6.17.y and 2.6.18.y ...  Was this an incorrect 
> assumption?

Greg told me they want to make one last 2.6.16.y release.

Greg and Chris don't maintain two series that long - check the date of 
the last 2.6.15.y release.

> ...and if not, should 2.6.16.y patches always be sent to 
> stable@kernel.org, or will Adrian have an alternate method for accepting 
> patches?

This is among the small technical issues that have to be discussed and 
solved.

> -Mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

