Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293736AbSB1UrC>; Thu, 28 Feb 2002 15:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSB1UpX>; Thu, 28 Feb 2002 15:45:23 -0500
Received: from www.transvirtual.com ([206.14.214.140]:34570 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293734AbSB1Uoi>; Thu, 28 Feb 2002 15:44:38 -0500
Date: Thu, 28 Feb 2002 12:44:26 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Dave Jones <davej@suse.de>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tdfx ported to new fbdev api
In-Reply-To: <20020228214045.E32662@suse.de>
Message-ID: <Pine.LNX.4.10.10202281242570.20040-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > As you can see I have ported the 3dfx fbdev driver to the new api. It has
>  > been tested on my home system and it works. I like others to try it out.
>  > The patch is against 2.5.5-dj2
>  > http://www.transvirtual.com/~jsimmons/tdfx.diff
> 
>  Is this one different to the one I saw last time?

Their are a few changes. I tested it last night and it worked for me. That
doesn't mean much so if you could give it a try. BTW the penguin will not
show up. I need to expand the imageblit function but it is not top
priority right now.


