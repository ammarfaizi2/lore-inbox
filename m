Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268242AbTALF7g>; Sun, 12 Jan 2003 00:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268243AbTALF7g>; Sun, 12 Jan 2003 00:59:36 -0500
Received: from adedition.com ([216.209.85.42]:44812 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S268242AbTALF7f>;
	Sun, 12 Jan 2003 00:59:35 -0500
Date: Sun, 12 Jan 2003 01:16:54 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: David Schwartz <davids@webmaster.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia and its choice to read the GPL "differently"
Message-ID: <20030112061654.GB15442@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 08:19:32PM -0800, David Schwartz wrote:
> On Sat, 11 Jan 2003 22:33:25 -0500, Mark Mielke wrote:
> > Why do I doubt the calibre of vxWorks? People I trust who work on
> > RT systems have told me that in many cases, products with RT
> > requirements can perform better on Linux, than on vxWorks. (Better
> > meaning managing a higher capacity without significant side
> > effects)
> 	This is an atrocious way to compare a real-time operating system to 
> a non-real-time operating system. One would expect that real-time's 
> benefits also come at a cost, otherwise all operating systems would 
> be real-time operating systems.

Atrocious how? My qualification "without significant side effects"
means just that - *without* *significant* *side* *effects*. Note that
I did not say web clients, but that below you assume web clients. I
don't know about you, but I don't consider a web server to be an RT
application.

> 	Perhaps Linux can handle more web clients than vxWorks, but can 
> Linux guarantee that if the temperature in the core coolant exceeds 
> 350 degrees, the secondary pump circuit will be activated within 13 
> milliseconds?

If you truly wanted to fit the requirements you list above (350
degress, secondary pump activated in < 13 milliseconds), I suggest you
use a hardware solution.

I remain very optimistic that Linux+RT will be able to handle more
capacity than vxWorks for the majority of RT applications.

> 	A cheap hammer can drive in more nails than a top of the line 
> screwdriver.

Any brand name hammer that is aggressively marketted, costs more to
produce per hammer, than its competitors that may produce just as
good of a hammer, without all the marketting costs.

But... this has gone too far off a dead thread. You obviously like
vxWorks. Quite a few people I socialize with curse vxWorks. That's
your freedom and their freedom. I don't want to be part of this
anymore. :-)  (Private query: What does webmaster.com use vxWorks for?)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

