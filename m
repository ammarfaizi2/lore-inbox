Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVFFTAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVFFTAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVFFTAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:00:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19420 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261626AbVFFTAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:00:20 -0400
Date: Mon, 6 Jun 2005 20:00:12 +0100 (BST)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: linux-fbdev-devel@lists.sourceforge.net
cc: adaplas@pol.net, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Linux-fbdev-devel] [RFC/PATCH 2.6.12-rc5 1/1] Framebuffer driver
 for Arc LCD board
In-Reply-To: <200506061416.j56EG18b017582@intworks.biz>
Message-ID: <Pine.LNX.4.56.0506061958450.16950@pentafluge.infradead.org>
References: <200506061416.j56EG18b017582@intworks.biz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Antonino, Andrew, FBdev folk,
> 
> I added akpm's fixes below, then further cleanup and irq support: 
> - coding style fixes
> - removing unneeded typecasts
> - namespace fixes
> 
> I had used skeletonfb.c to start with and that had fb_get_options.
> I've removed that and the redundant param retrieval from arcfb as 
> per akpm's mention of the redundancy of fb_get_options/*_setup. 
> I also cleaned up some other duplicate code. I've listed the 
> driver as maintained and added myself. I did this diff against
> rc5. Should I be doing it against -mm instead?
> 
> Please let me know if you have any feedback or suggestions.

It looks really good :-) Please apply.

