Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265962AbSKBMrc>; Sat, 2 Nov 2002 07:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265950AbSKBMqW>; Sat, 2 Nov 2002 07:46:22 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6916 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265958AbSKBMpl>;
	Sat, 2 Nov 2002 07:45:41 -0500
Date: Fri, 1 Nov 2002 23:25:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: shuey@purdue.edu, Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021101222504.GA460@elf.ucw.cz>
References: <Pine.LNX.4.44.0210302224180.20210-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com> <20021031171334.GA22597@snerble.cc.purdue.edu> <1036091071.8575.101.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036091071.8575.101.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm a user, and I request that LKCD get merged into the kernel. :-)
> > Do you feel like donating a 700-port console server?  Right, so it's LKCD
> > for me then.
> 
> Wouldn't you rather they neatly tftp'd dumps to a nominated central
> server which noticed the arrival, did the initial processing with a perl
> script and mailed you a summary ?

Out of interest, how does such "initial processing" look like?

Of course I'd like perl script to tell me

"hey, at vicam.c:715 you are freeing memory that is still in use by
usb.c; that crashed your machine 5 times during last week",

but I guess your perl scripts can't do that, right?
								Pavel
-- 
When do you have heart between your knees?
