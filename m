Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbREOU6I>; Tue, 15 May 2001 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbREOU56>; Tue, 15 May 2001 16:57:58 -0400
Received: from [206.14.214.140] ([206.14.214.140]:50438 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261503AbREOU5l>; Tue, 15 May 2001 16:57:41 -0400
Date: Tue, 15 May 2001 13:57:10 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151607100.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10105151339530.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You see, as soon as you want slightly more structured stuff (deeper than
> one level) you need the dentry tree, yodda, yodda. IOW, you need a
> filesystem anyway and it's easy to implement. Want me to do framebufferfs?
> Would make a nice demo.  No majors. No minors. No ioctls. Less code than
> in current tree.  ~3 days to implement.

Yes. I like to give this fbdevfs a try. Once tested I have no problem
placing it into my kernel tree I have. I planned on reworking the fbdev
layer anyways for 2.5.X. As Linus pointed out is the backwards
compatiabilty. Maybe name it to something else. Since I like to see fbdev
and drm merge we need a new name anyways. Later I can migrate DRI
functionality into this filesystem. It would be a nice demo. It would be
really cool if I could stream the framebuffer image over a network :-)
 


