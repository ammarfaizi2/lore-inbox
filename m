Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWCFLmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWCFLmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWCFLmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:42:40 -0500
Received: from math.ut.ee ([193.40.36.2]:33750 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750900AbWCFLmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:42:39 -0500
Date: Mon, 6 Mar 2006 13:34:50 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Adrian Bunk <bunk@stusta.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spontaneous reboots with latest 2.6.16 RC-s
In-Reply-To: <20060305162905.GC20287@stusta.de>
Message-ID: <Pine.SOC.4.61.0603061332510.26065@math.ut.ee>
References: <Pine.SOC.4.61.0603021501560.23598@math.ut.ee>
 <20060305162905.GC20287@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It could be, but it could also be hardware.
> Does the machine survive a night of memtest86?
>
> Please turn on all debugging options in the kernel.

Will try both of these.

> It's extremely unlikely that it's in any way related, but is this the
> machine you reported the psmouse problems for?

Yes, the same machine. The psmouse resync problem is also still there.

> Can you find a pattern that triggers the problem with a nearly 100%
> probability? E.g. "24 hours of mplayer fullscreen"?

I have not managed to trigger it any more at all (running 
2.6.16-rc5-gc499ec24 for 2 days and have let it play a lot of movies).

-- 
Meelis Roos (mroos@linux.ee)
