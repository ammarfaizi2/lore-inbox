Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbTCPDTg>; Sat, 15 Mar 2003 22:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262248AbTCPDTg>; Sat, 15 Mar 2003 22:19:36 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:17848 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S262242AbTCPDTf>; Sat, 15 Mar 2003 22:19:35 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Adam Spiers <arch-users@adamspiers.org>
Cc: arch-users@lists.fifthvision.net, linux-kernel@vger.kernel.org
Date: Sat, 15 Mar 2003 19:28:22 -0800 (PST)
Subject: Re: [arch-users] Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <20030316020617.GA5594@riffraff.plig.net>
Message-ID: <Pine.LNX.4.44.0303151927100.10545-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey guys, the suggestion to move to another list for this discussion was
to reduce traffic on the kernel list, not add a bunch of arch discussions
to the bitkeeper discussions.

pick one list and use it, don't use both.

David Lang

 On Sun, 16 Mar 2003, Adam Spiers wrote:

> Date: Sun, 16 Mar 2003 02:06:17 +0000
> From: Adam Spiers <arch-users@adamspiers.org>
> To: arch-users@lists.fifthvision.net, linux-kernel@vger.kernel.org
> Subject: Re: [arch-users] Re: BitBucket: GPL-ed KitBeeper clone
>
> Tom Lord (lord@emf.net) wrote:
> >   `+'-named log message files _are_ going to change to something more
> >   vi-friendly.  My bad.  I'm both an emacs user and a
> >   unix-traditionalist.  I didn't initially notice the problem and my
> >   reaction on hearing about it was "Well, vi is broken" -- but as a
> >   practical matter, arch does need to change in that area.
>
> Not that you need any more prodding on this direction, but it's worth
> noting that both more(1) and less(1) suffer from this problem too.
>
>   $ touch +foo
>   $ more +foo
>   usage: more [-dflpcsu] [+linenum | +/pattern] name1 name2 ...
>   $ less +foo
>   Missing filename ("less --help" for help)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
