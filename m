Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290062AbSAQRFq>; Thu, 17 Jan 2002 12:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290061AbSAQRFf>; Thu, 17 Jan 2002 12:05:35 -0500
Received: from www.transvirtual.com ([206.14.214.140]:11786 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290051AbSAQRFR>; Thu, 17 Jan 2002 12:05:17 -0500
Date: Thu, 17 Jan 2002 09:05:09 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev currcon
In-Reply-To: <Pine.GSO.4.21.0201151006470.12074-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10201170904420.25822-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > NOTE: The setcolreg patch has to be applied first.
> > 
> > http://www.transvirtual.com/~jsimmons/setcolreg.diff
> > http://www.transvirtual.com/~jsimmons/fbcurrcon.diff
> 
> You forgot the part that adds currcon to <linux/fb.h>.

That is already in the -dj branch :-)

