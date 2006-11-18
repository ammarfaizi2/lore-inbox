Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754366AbWKRKfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbWKRKfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbWKRKfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:35:45 -0500
Received: from opal.biophys.uni-duesseldorf.de ([134.99.176.7]:33506 "EHLO
	opal.biophys.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id S1754362AbWKRKfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:35:44 -0500
Date: Sat, 18 Nov 2006 11:34:41 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Adrian Bunk <bunk@stusta.de>
cc: adaplas@pol.net, James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org,
       linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
In-Reply-To: <20061118000235.GV31879@stusta.de>
Message-ID: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
References: <20061118000235.GV31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006, Adrian Bunk wrote:

> This patch removes video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
>
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_ATARI

FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
the final one soonish.

	Michael
