Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTCBB4r>; Sat, 1 Mar 2003 20:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269077AbTCBB4r>; Sat, 1 Mar 2003 20:56:47 -0500
Received: from [195.223.140.107] ([195.223.140.107]:38279 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267292AbTCBB4q>;
	Sat, 1 Mar 2003 20:56:46 -0500
Date: Sun, 2 Mar 2003 03:09:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz, hch@infradead.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030302020907.GE1364@dualathlon.random>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E616224.6040003@pobox.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 08:45:08PM -0500, Jeff Garzik wrote:
> Andrea Arcangeli wrote:
> >Jeff, please uninstall *notrademarkhere* from your harddisk, install the
> >patched CSSC instead (like I just did), rsync Rik's SCCS tree on your
> >harddisk (like I just did), and then send me via email the diff of the
> >last Changeset that Linus applied to his tree with author, date,
> >comments etc...  If you can do that, you're completely right and at
> >least personally I will agree 100% with you, again: iff you can.
> 
> 
> You're missing the point:
> 
> A BK exporter is useful.  A BK clone is not.
> 
> If Pavel is _not_ attempting to clone BK, then I retract my arguments. :)

hey, in your previous email you claimed all we need is the patched CSSC,
you change topic quick! Glad you agree CSSC alone is useless and to make
anything useful with Rik's *notrademarkhere* tree we need a true
*notrademarkhere* exporter (of course the exporter will be backed by
CSSC to extract the single file changes, since they're in SCCS format
and it would be pointless to reinvent the wheel).

Now you say the bitbucket project (you read Pavel's announcement, he
said "read only for now", that means exporter in my vocabulary) is
useful, to me that sounds the opposite of your previous claims, but
again: glad we agree on this too now.

Andrea
