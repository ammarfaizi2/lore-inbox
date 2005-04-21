Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVDUQNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVDUQNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 12:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDUQMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 12:12:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54744 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261499AbVDUQLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 12:11:00 -0400
Date: Thu, 21 Apr 2005 17:11:06 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 11:10:15AM +0200, Geert Uytterhoeven wrote:
> On Thu, 21 Apr 2005, Jan Dittmer wrote:
> > Linus Torvalds wrote:
> > > Geert Uytterhoeven:
> > >     [PATCH] M68k: Update defconfigs for 2.6.11
> > >     [PATCH] M68k: Update defconfigs for 2.6.12-rc2
> > 
> > Why do I still get this error when trying to cross-compile for m68k?
> 
> Because to build m68k kernels, you (still :-( have to use the Linux/m68k CVS
> repository, cfr. http://linux-m68k-cvs.ubb.ca/.
> 
> BTW, my patch queue is at
> http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/.
> The main offender is POSTPONED/156-thread_info.diff.

I think I have a sane splitup of that stuff.  If you have time to review - yell
