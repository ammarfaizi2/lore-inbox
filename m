Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbREOWwI>; Tue, 15 May 2001 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbREOWv6>; Tue, 15 May 2001 18:51:58 -0400
Received: from [206.14.214.140] ([206.14.214.140]:8456 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261684AbREOWvo>; Tue, 15 May 2001 18:51:44 -0400
Date: Tue, 15 May 2001 15:51:10 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Chip Salzenberg <chip@valinux.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515145934.L3098@valinux.com>
Message-ID: <Pine.LNX.4.10.10105151549580.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Graphics cards are the same way. Especially high end ones. They have pipes
> > as well. For low end cards you can think of them as single pipeline cards
> > with one pipe.
> 
> It still frosts my shorts that DRM (e.g. /dev/dri/card0) doesn't use
> write().  It's a natural way to feed pipelines.  But no, it's a raft
> of ioctl() calls.  *sigh*

I never liked this either. ioctl calls are slooooooooooooooooooooooooooow.

