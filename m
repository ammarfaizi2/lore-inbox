Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSDDTFe>; Thu, 4 Apr 2002 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293386AbSDDTFY>; Thu, 4 Apr 2002 14:05:24 -0500
Received: from www.transvirtual.com ([206.14.214.140]:53001 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293249AbSDDTFP>; Thu, 4 Apr 2002 14:05:15 -0500
Date: Thu, 4 Apr 2002 11:04:47 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Dave Jones <davej@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new fbdev api.
In-Reply-To: <20020404135817.Q20040@suse.de>
Message-ID: <Pine.LNX.4.10.10204041100590.1937-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Indeed, the fb changes are the largest chunk of -dj right now.
> The three heavy-weight patches pending integration by their maintainers
> make up for half of whats left to be resynced..
> 
> (davej@noodles:resync)$ ll new-*
> -rw-r--r--    1 davej    users      527576 Apr  1 21:48 new-console-layer.diff

Alot to go here. The merge is half way done. 

> -rw-r--r--    1 davej    users     2005697 Apr  1 03:12 new-fbdev.diff

I have more too :-/ I'm breaking it up as much as possible. I also have a 
few more changes/fixes to send your way but I'm going to wait for that.

> -rw-r--r--    1 davej    users      396297 Apr  1 19:01 new-input-layer.diff

I talked to Vojtech about this so they will be going in soon. 

