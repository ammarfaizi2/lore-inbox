Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTDYOYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDYOYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:24:04 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:14829 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S263260AbTDYOYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:24:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Werner Almesberger <wa@almesberger.net>
Subject: Re: Flame Linus to a crisp!
Date: Fri, 25 Apr 2003 16:37:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com> <20030424182945.7065812EFF1@mx12.arcor-online.net> <20030424201522.G1425@almesberger.net>
In-Reply-To: <20030424201522.G1425@almesberger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030425143613.8646E130965@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 April 2003 01:15, Werner Almesberger wrote:
> Daniel Phillips wrote:
> > Open source + Linux + DRM could be used to solve the Quake client-side
> > cheating problem:
>
> Yes, but in return you'd be excluded from playing Quake unless
> you're running one of those signed kernels or modules.
>
> So, if I, say, want to test some TCP fix, new VM feature, file
> system improvement, etc., none of the applications that rely on
> DRM would work. This doesn't only affect developers, but also
> their potential testers.

Yes, Ick.  You might see some kind of Linux-Trusted-Quake club rise up, with 
the specific goal of running cheatless deathmatches, but we are getting very 
far from reality here.

To get cheatless online gaming, you would have to necessarily give up a lot 
of flexibility.  I imagine the likelihood of people running completely 
separate DRM Linux boxes, just to participate in DRM-controlled online games, 
is not high.  Only when if you are faced with absolute necessity of running 
DRM, are you actually going to do it by choice.  There's going to be a whole 
pile of new ways for computers to fail to work too, because of this.  Then 
there's the certainty that there will be exploits - the whole concept is 
inherently fragile, there are just too many parts involved.  From a security 
point of view, we would end up worse off than without it, given a newfound 
false sense of security.

So, just call all of the above a valiant effort on my part to find something 
good about this.  Hopefully, after a few years of silliness and much wasted 
effort, it will all fade away like copy-protected floppy disks.

Regards,

Daniel
