Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSDTSGT>; Sat, 20 Apr 2002 14:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314677AbSDTSGS>; Sat, 20 Apr 2002 14:06:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37459 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313014AbSDTSGF>; Sat, 20 Apr 2002 14:06:05 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <5.1.0.14.2.20020420170907.06e87550@pop.cus.cam.ac.uk>
	<5.1.0.14.2.20020420170907.06e87550@pop.cus.cam.ac.uk>
	<5.1.0.14.2.20020420174422.00ad1390@pop.cus.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Apr 2002 11:58:11 -0600
Message-ID: <m1adry45ho.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cantab.net> writes:

> The fact that some developers use bitkeeper has no effect on other
> developers. Well ok, it means that the bk using developers can work faster but
> that is not at issue here...

Faster?  BK has no impact on the fundamentals of code development.  Only
on the problem of merging code.  Only when the bottle neck is merge speed
does it really come into play.  

For Linus this is obviously a very important issue.  For some of the
rest of us it is less so.

For myself I find great benefit in reviewing my own patches, and in
having other people look at them and review them.  I may be wrong
but I do not see bitkeeper helping in that regard (except reduce
the noise of renames).

Eric
