Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSEYUIW>; Sat, 25 May 2002 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSEYUIV>; Sat, 25 May 2002 16:08:21 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:48847 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315279AbSEYUIU>;
	Sat, 25 May 2002 16:08:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Karim Yaghmour <karim@opersys.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sat, 25 May 2002 22:07:37 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com> <3CEFCE9F.9C0D5A8C@opersys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BhpC-0003nd-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 May 2002 19:49, Karim Yaghmour wrote:
> > The thing that disgusts me is that this "patent" thing is used as a
> > complete red herring, and the real issue is that some people don't like
> > the fact that the kernel is under the GPL. Tough cookies.
> 
> I have no disagreement with the kernel being GPL.

I'd like to take this opportunity to take a turn back towards the original
issue: supposing that Ingo's/Red Hat's patented extension to the dcache is
accepted into the kernel.  Would not the GPL's patent trap provision
prevent Red Hat from distributing the result, unless Red Hat also provides
a license for the patent permitting unrestricted use *regardless of
commercial or noncommercial use* of the patent in the context of the GPL'd
code?  So it's either provide the license, or don't incorporate the code
into Linux.  (The issue of whether it's a good thing that the latter course
would also foreclose anybody else from using the same technique is
separate.)

Supposing that Red Hat distributes a version of Linux accompanied with the
appropriate license, so that the result can be distributed in compliance
with the GPL: could Red Hat then prevent other distributors from
distributing their own version of Linux that has the same extension?  I
hope not, otherwise we have a real problem.

-- 
Daniel
