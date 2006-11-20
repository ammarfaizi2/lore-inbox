Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966201AbWKTQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966201AbWKTQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966198AbWKTQv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:51:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5286 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966193AbWKTQv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:51:56 -0500
Date: Mon, 20 Nov 2006 16:51:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, geert@linux-m68k.org,
       zippel@linux-m68k.org, linux-m68k@vger.kernel.org,
       linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
In-Reply-To: <20061118000235.GV31879@stusta.de>
Message-ID: <Pine.LNX.4.64.0611201648550.17639@pentafluge.infradead.org>
References: <20061118000235.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch removes video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_ATARI
> - FB_SUN3
> - FB_PM3

If someone is willing to send me a Permedia3 card I can port the driver. 
The rest are m68k drivers. I do have S3Trio and a Virge card but no specs.

