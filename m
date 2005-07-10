Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVGJUeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVGJUeV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVGJUeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 16:34:05 -0400
Received: from atpro.com ([12.161.0.3]:55046 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262109AbVGJUc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 16:32:26 -0400
Date: Sun, 10 Jul 2005 16:21:29 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ed Tomlinson <tomlins@cam.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Ed Cogburn <edcogburn@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050710202129.GA3550@mail>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Ed Tomlinson <tomlins@cam.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Hans Reiser <reiser@namesys.com>, Ed Cogburn <edcogburn@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl> <200507100848.05090.tomlins@cam.org> <200507102006.27152.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507102006.27152.adobriyan@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/05 08:06:26PM +0400, Alexey Dobriyan wrote:
> On Sunday 10 July 2005 16:48, Ed Tomlinson wrote:
> > On Sunday 10 July 2005 01:10, Horst von Brand wrote:
> > > Ed Cogburn <edcogburn@hotpop.com> wrote:
> > > > David Lang wrote:
> > > > > On Fri, 8 Jul 2005, Ed Tomlinson wrote:
> > > 
> > > > >> No Flame from me.  One thing to remember is that Hans and friends
> > > > >> _have_ supported R3 for years.
> > > 
> > > They let it fall into disrepair when they started work on 4.
> > > 
> > > > >>                                This is an undisputed fact.
> > > 
> > > Exactly.
> > 
> > This is FUD.  Hans do you have figures on how many fixes for R3 have
> > been added in the last year or so?
> 
> You don't need Hans to find out how many. linux.bkbits.net is still online.
> 
> http://linux.bkbits.net:8080/linux-2.6/src/fs/reiserfs?nav=index.html|src/|src/fs

Which seems to support the notion that namesys stopped support for reiser3
when reiser4 was started. The tracking of who submittend and who committed
patches wasn't there just over a year ago so sometimes it's hard to tell 
who actually posted that patch if someone like Andrew or Linus committed it. 
But in most of the changesets on the bkbits site you can go back over 2 years 
and not see anything from namesys people. Nearly all of the fixes commited
in the past 2-3 years are from SuSe.

Jim.
