Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262645AbSJEUrL>; Sat, 5 Oct 2002 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSJEUrL>; Sat, 5 Oct 2002 16:47:11 -0400
Received: from web13201.mail.yahoo.com ([216.136.174.186]:64267 "HELO
	web13201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262645AbSJEUrK>; Sat, 5 Oct 2002 16:47:10 -0400
Message-ID: <20021005205238.47023.qmail@web13201.mail.yahoo.com>
Date: Sat, 5 Oct 2002 13:52:38 -0700 (PDT)
From: Gigi Duru <giduru@yahoo.com>
Subject: Re: The end of embedded Linux?
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now thats some advice from a kernel hacker... You
really don't seem to care too much about embedded, do
you? 

It's not about what I do not do, it's about what YOU
do (I'm not talking to you personally, but to the
hacker community as a whole). The kernel core didn't
jump to 270KB compressed because I didn't do
something.

Let me reformulate for you:
* some years ago, (2.2 era) I was more than happy
about embedding Linux.
* along came 2.4, and things got fuzzy (should we move
on, or stick to the good ol' stuff?)
* now, 2.6 (or whatever) seems like a very bad choice
for us.
* I wonder about the next one (2.8/whatever): will it
require a mainframe to run?

It's the trend, you see: you were on the right track
but now you're loosing it. From the embedded point of
view, YOU ARE GOING THE WRONG DIRECTION.

And don't give me the "use 2.2" advice. Stuff is being
back-ported, I know, but not all of it. 

Why are old versions being actively maintained anyway?
Isn't that a realization that those old versions are
better suited for some tasks than the new one? Why
would anyone choose to use 2.2? Because it serves him
better. 

Now, why is 2.2 serving someone better than 2.4?
That's something I'd like you to answer...

The beauty of Linux was it's scalability (I'm not
talking SMP here): you had the same kernel running on
the appliance, on the PC and on that mainframe. Things
were smooth, things were perfect. I would have loved
to preserve that...

Regards,
Gigi 

--- Andre Hedrick <andre@linux-ide.org> wrote:
> 
> Well have a nice day and go pay for windriver
> licenses, or use the source
> to adopt to your needs, or hire somebody who can do
> it for you.
> Whinning will not help, doing will.
> 
> Regards,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
