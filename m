Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270511AbUJUArR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270511AbUJUArR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270644AbUJUArA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:47:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17584 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270511AbUJUAoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:44:03 -0400
Date: Thu, 21 Oct 2004 01:44:02 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, John Cherry <cherry@osdl.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
Message-ID: <20041021004402.GE23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org> <41770307.5060304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41770307.5060304@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:29:59PM -0400, Jeff Garzik wrote:
> Current patch is at
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/patch.iomap.bz2

Got it.
 
> I still merging stuff, so won't get around to it for another day or so :)
> 
> I certainly don't mind anyone stealing the task from me, but the effort 
> is larger than the other iomap conversions.  The patch above hits all 
> the easily-picked fruit, leaving the stuff that requires a modicum of 
> effort:

Hey, it's not that there wasn't enough work in other places...  I've
picked the patch above for -bird and will happily leave further sata
stuff to you, TYVM ;-)

Speaking of which, since -bk5 is out there now...  Could you drop the delta
between it and your current netdev-2.6 somewhere on anonftp?  AFAICS there
are 6 patches missing from the pile I've sent to you (3 out of them with
objections I've seen + 1 you've asked to postpone), but there's another
pile waiting to be sent (11 more)...
