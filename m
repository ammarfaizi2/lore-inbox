Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbVIOXAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbVIOXAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbVIOXAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:00:49 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:8231 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161036AbVIOXAs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:00:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cxmiWyO8HUVyRI9OAtWIqtB+JVNGYBb7VFs/rGy/VxJXuu2x94/kCULxWAFYfkvdJdoAPKtd/xbRhd72GqClazqNLVa1HMuPT/k/Xsv1gwulbpel5tco6w8W9XPCz/3IZp7qKNMJhos0YmO7QBnkXaB+SEcwR/1HyScrVcZ7g+Q=
Message-ID: <9a874849050915160027db1fe9@mail.gmail.com>
Date: Fri, 16 Sep 2005 01:00:45 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: early printk timings way off
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509151554450.29737@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509152342.24922.jesper.juhl@gmail.com>
	 <Pine.LNX.4.58.0509151458330.1800@shark.he.net>
	 <9a87484905091515072c7dd4a8@mail.gmail.com>
	 <Pine.LNX.4.58.0509151537140.29737@shark.he.net>
	 <9a87484905091515495f435db7@mail.gmail.com>
	 <Pine.LNX.4.58.0509151554450.29737@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
[snip]
> > >
> > > OK, thanks for the extended explanation.  Good luck.  8:)
> > >
> >
> > Ok, I don't quite know how to interpret that comment, but I'm going to
> > read it as "if you think this is a problem then go find a solution
> > yourself" - would that be fairly accurate?
> 
> Yes, that's close.  I have "bigger fish to fry" is another way.
> 
Ok, thanks. English is not my native language and sometimes the actual
meaning of sarcasm, slang etc escapes me...

> > It doesn't really bother me much, I just find the behaviour odd. I
> > haven't bothered to actually look at the code responsible for it yet
> > (since it really is not that big of a deal), but I just wanted to
> > point it out and hoped that maybe someone could give me a reason for
> > why it is as it is...
> 
> ISTM that there have been a few other comments about it, but I'm
> not sure.  Maybe Tim Bird (Sony, CELF) would recall.
> 

I'll just dig into it myself for now, but thank you, if I get really
stuck I may ask him.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
