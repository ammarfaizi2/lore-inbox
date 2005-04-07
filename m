Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVDGVJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVDGVJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVDGVJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:09:35 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:43805 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262601AbVDGVJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:09:08 -0400
X-ME-UUID: 20050407210903191.2ED3A180009E@mwinf0801.wanadoo.fr
Date: Thu, 7 Apr 2005 23:05:05 +0200
To: Adrian Bunk <bunk@stusta.de>, Sven Luther <sven.luther@wanadoo.fr>,
       Humberto Massa <humberto.massa@almg.gov.br>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407210505.GB17963@pegasos>
References: <h-GOHD.A.KL.s2aUCB@murphy> <42527E89.4040506@almg.gov.br> <20050405135701.GA24361@pegasos> <20050407205647.GB4325@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050407205647.GB4325@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 10:56:47PM +0200, Adrian Bunk wrote:
> On Tue, Apr 05, 2005 at 03:57:01PM +0200, Sven Luther wrote:
> >...
> > The other point is that other entities, like redhat, or suse (which is now
> > novel and thus ibm) and so have stronger backbones, and can more easily muster
> > the ressources to fight of a legal case, even one which is a dubious one,
> > especially given the particularities of the US judicial system, where it is
> > less important to be right, and more important to have lot of money to throw
> > at your legal machine. Debian has nothing such, and SPI which would stand for
> > this, is not really upto it either, so in this case, apart from all ideology
> > and fanatism, it is for purely pragmatic reasons that they don't distribute
> > undistributable files from the non-free part of our archive. You would do the
> > same in their case.
> >...
> 
> 
> There are many possible legal risks for a Linux distribution.
> 
> 
> This thread is about one.
> 
> Another one is that RedHat removed MP3 support in their distribution 
> from programs like xmms ages ago because of the legal risks due to 
> patents. The Debian distribution still contains software that is capable 
> of playing MP3's.
> 
> 
> I'd say of the two above cases, the MP3 patents are far more likely to 
> cause a lawsuit.
> 
> YMMV.

Yes, possibly, especially in these troubled times.

> If your statement was true that Debian must take more care regarding 
> legal risks than commercial distributions, can you explain why Debian 
> exposes the legal risks of distributing software capable of decoding 
> MP3's to all of it's mirrors?

I don't know and don't really care. I don't maintain any mp3 player (err,
actually i do, i package quark, but use it mostly to play .oggs, maybe i
should think twice about this now that you made me aware of it), but in any
case, i am part of the debian kernel maintainer team, and as such have a
responsability to get those packages uploaded and past the screening of the
ftp-masters. I believe the planned solution is vastly superior to the current
one of simply removing said firmware blobs from the drivers, which caused more
harm than helped, which is why we are set to clarifying this for the
post-sarge kernels. 

That said, i was under the understanding that after the SCO disaster,
clarification of licencing issues and copyright attributions was a welcome
thing here, but maybe i misunderstood those whole issues.

Friendly,

Sven Luther

