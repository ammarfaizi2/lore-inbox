Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbTCZT4t>; Wed, 26 Mar 2003 14:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbTCZT4s>; Wed, 26 Mar 2003 14:56:48 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:38406 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261707AbTCZT4k>; Wed, 26 Mar 2003 14:56:40 -0500
Date: Wed, 26 Mar 2003 20:07:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Scott Robert Ladd <coyote@coyotegulch.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
In-Reply-To: <3E81B317.3080504@coyotegulch.com>
Message-ID: <Pine.LNX.4.44.0303262007240.21188-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > As usually I have a patch avalaible at 
> > The patch has updates for the ATI Rage 128, Control, and Platnium 
> > framebuffer driver. The Radeon patch adds PLL times for the R* series of
> > cards. Memory is now safe to allocate for the software cursor and inside 
> > fbcon. There still are issues with syncing which cause the cursor on some 
> > systems to become corrupt sometimes. 
> 
>  From your description, this doesn't sound like these patches solve the 
> problem with radeonfb not detecting a DFP connected to the DVI. I posted 
> a message about this bug a week ago, and am more than willing to look 
> into fixing it myself if it isn't on your schedule.

If you have the docs and teh ahrdware could you? I don't have either.


