Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUJWDFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUJWDFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269283AbUJWDDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:03:02 -0400
Received: from waste.org ([209.173.204.2]:44208 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269802AbUJWCwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:52:47 -0400
Date: Fri, 22 Oct 2004 21:52:37 -0500
From: Matt Mackall <mpm@selenic.com>
To: alan <alan@clueserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041023025237.GK31237@waste.org>
References: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org> <Pine.LNX.4.44.0410221807140.30372-100000@www.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410221807140.30372-100000@www.fnordora.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 06:08:12PM -0700, alan wrote:
> On Fri, 22 Oct 2004, Linus Torvalds wrote:
> 
> > 
> > 
> > Hey guys, calm down, I meant "naming wars" in a silly kind of way, not the 
> > nasty kind.
> > 
> > The fact is, Linux naming has always sucked. Well, at least the versioning 
> > I've used. Others tend to be more organized. Me, I'm the "artistic" type, 
> > so I sometimes try to do something new, and invariably stupid. 
> > 
> > The best suggestion so far has been to _just_ use another number, which
> > makes sense considering my dislike for both -rc and -pre.
> > 
> > However, for some reason four numbers just looks visually too obnoxious to
> > me, so as I don't care that much, I'll just use "-rc", and we can all
> > agree that it stands for "Ridiculous Count" rather than "Release
> > Candidate".
> > 
> > More importantly, maybe we could all realize that it isn't actually that 
> > big of an issue ;)
> 
> Besides...  -pre and -rc additions do not sort correctly unless your sort 
> routine has special cases to take care of it.

I've got a good page or so of compare function in ketchup already, I'm
loathe to teach it about -final though. 

-- 
Mathematics is the supreme nostalgia of our time.
