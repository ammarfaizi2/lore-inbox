Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSDTSfI>; Sat, 20 Apr 2002 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313025AbSDTSfI>; Sat, 20 Apr 2002 14:35:08 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:61987 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313022AbSDTSfH>; Sat, 20 Apr 2002 14:35:07 -0400
Message-Id: <5.1.0.14.2.20020420192100.06dd8bb0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 20 Apr 2002 19:35:10 +0100
To: ebiederm@xmission.com (Eric W. Biederman)
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1adry45ho.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:58 20/04/02, Eric W. Biederman wrote:
>Anton Altaparmakov <aia21@cantab.net> writes:
> > The fact that some developers use bitkeeper has no effect on other
> > developers. Well ok, it means that the bk using developers can work 
> faster but
> > that is not at issue here...
>
>Faster?  BK has no impact on the fundamentals of code development.  Only
>on the problem of merging code.  Only when the bottle neck is merge speed
>does it really come into play.

I would disagree personally. The more I play with the GUI tools provided by 
bitkeeper the more interesting things i discover. For example actually 
SEEING how patches fit together, being able to see what each patch did, 
looking at a file and having each line annotated as to who added it and in 
which patch makes it easier for me to understand how the code I am trying 
to understand has evolved and why certain things are the way they are. But 
that is something very personal to me, others may not find it useful...

>For Linus this is obviously a very important issue.  For some of the
>rest of us it is less so.
>
>For myself I find great benefit in reviewing my own patches, and in
>having other people look at them and review them.  I may be wrong
>but I do not see bitkeeper helping in that regard (except reduce
>the noise of renames).

I really like the way bk citool works because it makes my changelogs a lot 
more useful as I actually see what I have changed when writing them. But 
again, that is just me...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

