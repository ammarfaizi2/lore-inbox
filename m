Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJQJbV>; Thu, 17 Oct 2002 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJQJbV>; Thu, 17 Oct 2002 05:31:21 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:34297 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261264AbSJQJbU>;
	Thu, 17 Oct 2002 05:31:20 -0400
Date: Thu, 17 Oct 2002 11:36:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>
cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdev changes.
In-Reply-To: <1034813995.563.32.camel@daplas>
Message-ID: <Pine.GSO.4.21.0210171135300.29253-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Oct 2002, Antonino Daplas wrote:
> -	__u8  depth;	/* Dpeth of the image */
> +	__u8  depth;	               /* Dpeth of the image */
                                          ^^^^^
Please kill the spelling errors while re-indenting the code :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

