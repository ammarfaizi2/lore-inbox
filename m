Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWJHR7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWJHR7O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWJHR7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:59:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14863 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751298AbWJHR7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:59:13 -0400
Date: Sun, 8 Oct 2006 19:59:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008175908.GG6755@stusta.de>
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com> <20061008045522.GG29474@stusta.de> <1160283948.10192.3.camel@lade.trondhjem.org> <20061008063943.GB6755@stusta.de> <84144f020610080045s6d2d1b06o6fc78bfb8fbf4d77@mail.gmail.com> <20061008172859.GD6755@stusta.de> <20061008173445.GN30283@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008173445.GN30283@lug-owl.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 07:34:46PM +0200, Jan-Benedict Glaw wrote:
> On Sun, 2006-10-08 19:28:59 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> > On Sun, Oct 08, 2006 at 10:45:50AM +0300, Pekka Enberg wrote:
> > > On Sun, Oct 08, 2006 at 01:05:48AM -0400, Trond Myklebust wrote:
> > > >> In any case, what the fuck gives you the right to appoint yourself judge
> > > >> and jury over kernel regressions?
> > > 
> > > On 10/8/06, Adrian Bunk <bunk@stusta.de> wrote:
> > > >I've given this right myself - everyone can always send any bug list he
> > > >wants to linux-kernel.
> > > 
> > > I don't see what the problem here is. As stated in the bug report, a
> > > patch signed off by you broke something in the kernel which is not yet
> > > fixed in -git. Aside from calling people "guilty", what Adrian is
> > > doing is a service to us all.
> > 
> > It seems the word "Guilty" was considered offensive by some people?
> 
> I'd find it offensive, too, when I'd be called "guilty" because a
> patch broke something that was buggy.

Some people have no problem being called

  Didn't do anything, the scurvy lad. Ahoy!

while other people consider the word "Guilty" quite offensive.

All I can say is that my list is not meant in any was as an offence - 
bugs always happen when writing software, and the intention of my list 
is simply to summarize as much information as possible about known 
regressions.

> Read the bug report: Seems it
> was actually caused by a non-initialized variable introduced by a
> patch to util-linux.

It was the sum of two independent bugs, and one of them was a kernel bug.

> > This wasn't my intention, and I've replaced it with "Caused-By".
> 
> Made-visible-by :)
> 
> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

