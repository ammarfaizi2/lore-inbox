Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSD2SCK>; Mon, 29 Apr 2002 14:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314239AbSD2SCJ>; Mon, 29 Apr 2002 14:02:09 -0400
Received: from www.transvirtual.com ([206.14.214.140]:4104 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S314096AbSD2SCI>; Mon, 29 Apr 2002 14:02:08 -0400
Date: Mon, 29 Apr 2002 11:01:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 2.5.11 framebuffer compilation error 
In-Reply-To: <02042823533500.06684@cobra.linux>
Message-ID: <Pine.LNX.4.10.10204291056490.15166-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'll know this kernel is ready for merger with the 2.4 when I can finally 
> compile it :) ... must have tried 6-7 versions by now ...
> 
> Error:
> Note...this is something new that I haven't tried to compile before.
> Error might be caused by an earlier kernel.
> However, 2.5.11 does contain a lot of screen_base changes. 

Thats my fault. I had all the correct changes locally but my experience
with BK is just starting :-/ So this first time was a bit painful. I
asked people to tes my stuff but no one compiled so I toke that as
everything was okay. Please folks. Test the stuff. I even make classic
diff patches for people as well. 

I have fixes against 2.5.11 avaliable for this.

Diff:

http://www.transvirtual.com/~jsimmons/fbdev_fixs.diff

Also I commited these changes to the BK repository. The URL for this is

http://fbdev.bkbits.net/fbdev-2.5


