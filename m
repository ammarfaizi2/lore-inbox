Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSKCTAv>; Sun, 3 Nov 2002 14:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSKCTAv>; Sun, 3 Nov 2002 14:00:51 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:6075 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262322AbSKCTAo>;
	Sun, 3 Nov 2002 14:00:44 -0500
Date: Sun, 3 Nov 2002 20:07:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103200704.A8377@ucw.cz>
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DC56270.8040305@pobox.com>; from jgarzik@pobox.com on Sun, Nov 03, 2002 at 12:52:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:
> Jos Hulzink wrote:
> 
> >It took me about an hour to find out why my keyboard didn't work in 2.5.45. 
> >Well... after all it seemed that I need to enable 4 ! options inside the 
> >input configuration, just to get my default, nothing special PS/2 keyboard up 
> >and running. Oh, and I didn't even have my not so fancy boring default PS/2 
> >mouse configured then. Guys, being able to configure everything is nice, but 
> >with the 2.5 kernel, things are definitely getting out of control IMHO.
> >  
> >
> 
> This is potentially becoming a FAQ...  I ran into this too, as did 
> several people in the office.  People who compile custom kernels seem to 
> run into this when they first jump into 2.5.x.  AT Keyboard support is 
> definitely buried :/
> 
> Unfortunately I don't have any concrete suggestions for Vojtech (input 
> subsystem maintainer), just a request that it becomes easier and more 
> obvious how to configure the keyboard and mouse that is found on > 90% 
> of all Linux users computers [IMO]...

Too bad you don't have any suggestions. I completely agree this should
be simplified, while I wouldn't be happy to lose the possibility of not
compiling AT keyboard support in.

-- 
Vojtech Pavlik
SuSE Labs
