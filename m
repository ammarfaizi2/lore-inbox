Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWIJJkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWIJJkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 05:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWIJJkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 05:40:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29704 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750841AbWIJJkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 05:40:20 -0400
Date: Sun, 10 Sep 2006 09:40:07 +0000
From: Pavel Machek <pavel@ucw.cz>
To: curious <curious@zjeby.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp problem
Message-ID: <20060910094007.GA4973@ucw.cz>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 10-09-06 02:13:13, curious wrote:

Can we get some real name? I guess my spam filters ate this...


> i write because swsuspend don't work for me.
> i try to echo disk > /sys/power/state
> and just nothing happens, i have blinking cursor and 
> machine freezes.
> 
> when i enabled debug i got :
> stopping tasks: ========|
> Shrinking memory... done (2684 pages freed)
> swsusp: Need to copy 1454 pages
> swsusp: critical section/: done (1454 pages copied)
> 
> .... and machine just sits there , doing nothing.
> after reboot it boots like usual.

> 
> machine is Ts30M Viglen Dossier 486 SM

intel 486 cpu?

Can you try with minimal config?
							Pavel

-- 
Thanks for all the (sleeping) penguins.
