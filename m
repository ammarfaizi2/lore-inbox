Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSJTObO>; Sun, 20 Oct 2002 10:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbSJTObO>; Sun, 20 Oct 2002 10:31:14 -0400
Received: from faui80.informatik.uni-erlangen.de ([131.188.38.1]:6652 "EHLO
	faui80.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262780AbSJTObN>; Sun, 20 Oct 2002 10:31:13 -0400
From: Richard Zidlicky <rdzidlic@immd8.informatik.uni-erlangen.de>
Date: Sun, 20 Oct 2002 16:37:16 +0200 (MEST)
Message-Id: <200210201437.g9KEbGk00427@faui8s7.informatik.uni-erlangen.de>
To: axboe@suse.de, phillips@arcor.de
Subject: Re: 2.4 mm trouble [possible lru race]
Cc: riel@conectiva.com.br, zippel@linux-m68k.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tuesday 01 October 2002 20:04, Jens Axboe wrote:
> > On Tue, Oct 01 2002, Daniel Phillips wrote:
> > > On Tuesday 01 October 2002 19:31, Jens Axboe wrote:
> > > > Again, m68k was the target.
> > > 
> > > Sure fine, no good reason to be cryptic about it though.
> > > 
> > >    #error "m68k doesn't do SMP yet"
> > > 
> > > So SMP must be off or the compile would abort.  Well, the only interesting
> > 
> > There's no CONFIG_SMP in the m68k arch config.in. Anyways, enough
> > beating of dead horse :)
> 
> The horse isn't dead yet, it's still twitching a little.  At this
> point we still need to speculate about wny anyone would want an SMP
> Dragonball machine ;-)

not on Dragonball but there were many 68040 SMP systems around long 
before Intel had anything SMP capable. In the late 80'ies those were 
considered real number crunchers :)

Richard

