Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbRLPAVE>; Sat, 15 Dec 2001 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284153AbRLPAUy>; Sat, 15 Dec 2001 19:20:54 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:37604 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284144AbRLPAUn>; Sat, 15 Dec 2001 19:20:43 -0500
Date: Sat, 15 Dec 2001 19:19:37 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Dropped patches
Message-ID: <20011215191937.B30548@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10112151049260.13398-100000@master.linux-ide.org> <3C1BA20B.48FF8735@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1BA20B.48FF8735@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Dec 15, 2001 at 02:18:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 02:18:35PM -0500, Jeff Garzik wrote:
> Andre Hedrick wrote:
> > Well blame that on the folks that are not taking kernel code that will
> > allow you to solve this problem.  Linus is the number one offender.
> 
> Linus is taking some patches and not others right now...  so what?  A
> couple of my patches, isolated and clearly unrelated to bio and mochel's
> driver work, made it in.  Others got dropped.

Patches that are unrelated to bio and obviously correct shouldn't be dropped 
indefinately, or if they're being deferred, then $maintainer should say so.

> I do not believe this as a personal condemnation of your patches, or
> bcrl's, or anyone else's.
> 
> Patience is a virtue ;-)   We have a long devel series in front of us
> and we are only at the pre-patches to the FIRST 2.5.x release.

There is no reason not to have a 6 month devel cycle, and plenty of reasons 
in favour of it.  If people aren't going to bother reviewing patches in a 
timely fashion, they should tell people when a good time to resend patches 
is.  Given the whole vm fiasco in 2.4 (which is still a mess and falling 
apart for heavy loads) which stems from a lot of random direction with 
patches, I hope that some of the underlying problems will get fixed.  But 
it really doesn't look that way.

		-ben
-- 
Fish.
