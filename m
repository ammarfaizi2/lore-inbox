Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290232AbSA3RJ2>; Wed, 30 Jan 2002 12:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290206AbSA3RI2>; Wed, 30 Jan 2002 12:08:28 -0500
Received: from www.transvirtual.com ([206.14.214.140]:42500 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290227AbSA3RHz>; Wed, 30 Jan 2002 12:07:55 -0500
Date: Wed, 30 Jan 2002 09:07:18 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev accel wrapper. II
In-Reply-To: <20020130102147.C16937@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10201300905260.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, Jan 29, 2002 at 03:59:26PM -0800, James Simmons wrote:
> >     if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR)
> >         region.color = attr_bgcol_ec(p,vc);
> >     else 
> >         region.color = info->pseudo_palette)[attr_bgcol_ec(p,vc)];
>                         ^                    ^
> 
> I hope this is a typing mistake that's not present in the real source. 8)

The above is my pseudo code I wrote in the email. 


