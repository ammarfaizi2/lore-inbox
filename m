Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbULRAut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbULRAut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbULRAut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:50:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60690 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262793AbULRAub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:50:31 -0500
Date: Sat, 18 Dec 2004 01:50:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: patrick@tykepenguin.com, Steve Whitehouse <SteveW@ACM.org>,
       linux-decnet-user@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/decnet/: misc possible cleanups
Message-ID: <20041218005027.GC21288@stusta.de>
References: <20041214125838.GC23151@stusta.de> <20041214133235.GB10131@souterrain.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214133235.GB10131@souterrain.chygwyn.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 01:32:35PM +0000, Steven Whitehouse wrote:

> Hi,

Hi Steven,

>...
> Also, when I was writing the routing code - a lot of the design was "borrowed"
> from the ipv4 routing code. It might be worth doing a comparison to see where
> the two have diverged (something I used to do now and again) to pick up any
> bugs I'd inadvertently copied over, if you are working on clean ups in this
> area,

unfortunately, I'm not working especially in this area.

I'm currently going through the complete kernel sources searching for 
global code that can be made static or even removed.

> Steve.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

