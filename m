Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317350AbSFCKRE>; Mon, 3 Jun 2002 06:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSFCKRD>; Mon, 3 Jun 2002 06:17:03 -0400
Received: from dsl-213-023-039-253.arcor-ip.net ([213.23.39.253]:47007 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317350AbSFCKRC>;
	Mon, 3 Jun 2002 06:17:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] kbuild-2.5: quote Menuconfig quotemarks
Date: Mon, 3 Jun 2002 12:16:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Keith Owens <kaos@ocs.com.au>
In-Reply-To: <Pine.LNX.4.44.0206022108350.32102-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Eot5-0000sM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 04:23, Kai Germaschewski wrote:
> On Sun, 2 Jun 2002, Linus Torvalds wrote:
> 
> >  are you willing to integrate the kbuild patches (or whatever subset of
> > them you find appropriate)? The split-up looks reasonable, but I'd rather
> > have somebody else (and neutral) do the final integration..
> 
> I sure am willing to integrate what I find appropriate. (I already said
> that I was going to do that before, when Sam Ravnborg posted some
> functionally split out pieces form kbuild-2.5). This surely doesn't
> include the patches which just were the original kbuild-2.5 split into
> "add this new file, then add that new file" patches, though.
> 
> Please, everybody, give me some time to do so, my queue of patches to
> clean up, test and submit is already beyond any reasonable limit, so it
> won't be done by the day after tomorrow. When I'm done integrating what I 
> find appropriate, I'd be more than happy to discuss what else other people 
> want, but please let me do that part first, so that we have a reasonable 
> basis to start from. I also hope that at that point the discussion will be 
> much less heated.
> 
> So if you have split patches, which do one thing at a time (as opposed to 
> nothing or N things at a time, where N >> 1), feel free to send them to me 
> and bug me about it - no need to resend stuff which was already on the 
> list, though...

Just to be clear, this should be directed at "Lightweight patch manager
<patch@luckynet.dynu.com>", aka Thunder.  Thanks, Kai.

-- 
Daniel
