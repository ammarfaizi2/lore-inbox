Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSA2S5m>; Tue, 29 Jan 2002 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289829AbSA2S5c>; Tue, 29 Jan 2002 13:57:32 -0500
Received: from rakis.net ([207.8.143.12]:42929 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S289823AbSA2S5P>;
	Tue, 29 Jan 2002 13:57:15 -0500
Date: Tue, 29 Jan 2002 13:57:10 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <Pine.LNX.4.42.0201291347400.21942-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a little bit of input from the masses.  I'm not much of a developer
at this point, but I have been reading lkml for several months and there
have been a few things I've noticed on this topic.

As people on both sides of this argument have pointed out, one single
person can only do so much.  No matter how good you are, you're not going
to catch everything.  Due to this, I'd like to suggest a dual
maintainership.  A primary maintainer for the bug changes, and a secondary
for any small bits that fall through the crack.

The thing about this method is that it's already been proven to work.
Before Marcelo took over 2.4, Linus was the primary maintainer, and Alan
was making sure that the small bits weren't forgotten (As well as
providing some testing for some major changes before they were quite
ready).

Dave Jones appears to be taking the same roll in the 2.5 series, and Alan
is coming back a bit for 2.4 again.

Why not make it official?  The dual tree system seems to work.  It
would be quite similiar to Debian's release system.  A stable, and a
testing branch.  As long as the patches from the secondary maintainer gets
handled in a timely manner, less small changes will fall through the
crack.

Just my 2 cents.

Greg Boyce

