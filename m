Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbTCQT1Q>; Mon, 17 Mar 2003 14:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbTCQT1Q>; Mon, 17 Mar 2003 14:27:16 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:20604 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S261826AbTCQT1K>; Mon, 17 Mar 2003 14:27:10 -0500
Date: Tue, 18 Mar 2003 06:23:41 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: Ptrace hole / Linux 2.2.25
In-Reply-To: <20030317182741.GB2145@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.05.10303180613040.29730-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Tomas Szepe wrote:

> > [alan@lxorguk.ukuu.org.uk]
> > 
> > On Mon, 2003-03-17 at 18:20, Tomas Szepe wrote:
> > > Is this critical enough for 2.4.21 to go out?  Or can it wait like
> > > some other fairly serious stuff such as the ext3 fixes?  What about
> > > the current state of IDE?
> > > 
> > > Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> > > or 2.4.20.1 with only the critical stuff applied?
> > 
> > If you build your own kernels apply the patch, if you use vendor kernels
> > then you can expect vendor kernel updates to appear or have already
> > appeared
> 
> You have avoided the question(s).  8)

I think Alan's trying to teach us how to fish ;-)

That said, IMVHO something like this does constitute an argument for
2.4.20-p1 (due to the amount of change that's already racked up for
2.2.21).

Regards,
Neale.

