Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTJ0Xf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTJ0Xf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:35:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:25310 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263768AbTJ0XfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:35:23 -0500
Date: Mon, 27 Oct 2003 15:43:33 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: George Anzinger <george@mvista.com>
cc: Pavel Machek <pavel@suse.cz>, John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
In-Reply-To: <3F9DA930.9010103@mvista.com>
Message-ID: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, but then is there some sort of house cleaning that happens to clean up the 
> mess?  I am thinking something like the run level change where scripts might run 
> to "fix" things.
> 
> Now it could be that my ignorance is showing here, possibly this is all being 
> done already...

No, it's not. But, it should. 

Userspace behavior on suspend transitions is still a bit fuzzy at best. I 
am beginning to look at userspace requirements, so if anyone wants to send 
me suggestions, no matter how trivial or wacky, please feel free (on- or 
off-list). 

Thanks,


	Pat

