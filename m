Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSLJGQJ>; Tue, 10 Dec 2002 01:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266623AbSLJGQJ>; Tue, 10 Dec 2002 01:16:09 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:6528 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S266622AbSLJGQI>; Tue, 10 Dec 2002 01:16:08 -0500
Date: Tue, 10 Dec 2002 17:22:58 +1100
From: CaT <cat@zip.com.au>
To: James Simmons <jsimmons@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51 (fbcon issues)
Message-ID: <20021210062258.GA667@zip.com.au>
References: <20021210055205.GA615@zip.com.au> <Pine.LNX.4.33.0212092250400.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212092250400.2617-100000@maxwell.earthlink.net>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:52:18PM -0800, James Simmons wrote:
> > On Mon, Dec 09, 2002 at 07:17:19PM -0800, Linus Torvalds wrote:
> > CONFIG_FB=y
> > CONFIG_FB_VGA16=y
> 
> Remove that. I bet its getting confussed between VESA and the vga16fb
> driver.
> 
> I would recommend you also disable VGA_CONSOLE.

I removed both and it works fine. thanks. :)

It also seems a lot faster then the 2.4.x version which is way-cool. :)

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
