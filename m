Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTA3A3H>; Wed, 29 Jan 2003 19:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTA3A3H>; Wed, 29 Jan 2003 19:29:07 -0500
Received: from fmr02.intel.com ([192.55.52.25]:17602 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265872AbTA3A3G>; Wed, 29 Jan 2003 19:29:06 -0500
Date: Thu, 30 Jan 2003 08:35:25 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Scott Murray <scottm@somanetworks.com>
cc: Rusty Lynch <rusty@linux.co.intel.com>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] [RFC] Enhance CPCI Hot Swap driver
In-Reply-To: <Pine.LNX.4.44.0301291318200.17194-100000@rancor.yyz.somanetworks.com>
Message-ID: <Pine.LNX.4.44.0301300833270.15010-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Scott Murray wrote:

> On 28 Jan 2003, Rusty Lynch wrote:
> 
> > On Tue, 2003-01-28 at 23:50, Stanley Wang wrote:
> > > Hi, Scott,
> > > After reading your CPCI Hot Swap support codes, I have a suggestion
> > > to enhance it:
> > > How about to make it be full hot swap compliant?
> > > I mean we could also do some works like "disable_slot" when we receive
> > > the #ENUM & EXT signal. Hence the user could yank the hot swap board 
> > > without issuing command on the console.
> > > How do you think about it?
> > > 
> > 
> > How does this behavior translate to "full hot swap compliant"?  I assume
> > you are talking about wording from PICMG 2.16, which in my opinion
> 
> Slight nitpick, I'm pretty sure you mean PICMG 2.12 here, it's the  
> (somewhat lame IMO :) hotswap software spec, 2.16 is the packet switched 
> backplane stuff.
Yeah, I mean PCIMG 2.12 here.

Regards,
-Stan
-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


