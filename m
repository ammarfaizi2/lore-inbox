Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWBSToI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWBSToI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWBSToI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:44:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40095 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750911AbWBSToH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:44:07 -0500
Date: Sun, 19 Feb 2006 20:43:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060219194343.GA15311@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org> <43F8C464.3000509@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F8C464.3000509@cfl.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >since there's no difference (as far as the kernel can see) between power
> >loss on the bus and an actual unplug, you can hardly say that one should
> >be allowed and the other not.
> 
>   But there _IS_ a difference between power loss and actual unplug, so 
> I very well can say one is allowed and the other is not.  The fact that 
> the kernel can not tell the difference is simply a limitation that must 
> be dealt with.

Kernel can not tell the diference, and just because you don't like the
behaviour does not mean we have to work around hardware limitation.

You deal with it. Post a patch.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
