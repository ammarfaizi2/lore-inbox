Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVBRVe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVBRVe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBRVe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:34:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48044 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261524AbVBRVc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:32:56 -0500
Date: Fri, 18 Feb 2005 21:32:38 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: 2.6: drivers/input/power.c is never built
In-Reply-To: <20050218174826.GA2136@ucw.cz>
Message-ID: <Pine.LNX.4.56.0502182132080.25766@pentafluge.infradead.org>
References: <20050213004729.GA3256@stusta.de> <20050218160153.GC12434@elf.ucw.cz>
 <20050218170036.GA1672@ucw.cz> <200502181805.13129.oliver@neukum.org>
 <20050218174826.GA2136@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All you'd need is input.c. One file, approx 750 lines at the moment, a
> big chunk of that can be confugured out if you don't need procfs or
> hotplug.
> 
> > Think about embedded stuff I wonder whether this is viable.
> 
> On most embedded platforms you have some buttons or controls, so it's
> likely you'll use input anyway.

I have always used the input api on embedded devices.

