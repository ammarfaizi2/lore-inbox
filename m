Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTBNQ7n>; Fri, 14 Feb 2003 11:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTBNQ7n>; Fri, 14 Feb 2003 11:59:43 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:18304 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261398AbTBNQ7i>; Fri, 14 Feb 2003 11:59:38 -0500
Date: Fri, 14 Feb 2003 18:09:15 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>,
       David Lang <david.lang@digitalinsight.com>,
       "Matthew D. Pitts" <mpitts@suite224.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
Message-ID: <20030214170915.GE200@louise.pinerecords.com>
References: <Pine.LNX.4.44.0302132224470.656-100000@dlang.diginsite.com> <1045233701.7958.14.camel@irongate.swansea.linux.org.uk> <20030214153039.GB3188@work.bitmover.com> <1045241763.1353.19.camel@irongate.swansea.linux.org.uk> <20030214164720.GC200@louise.pinerecords.com> <20030214165041.GA6564@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214165041.GA6564@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [lm@bitmover.com]
> 
> > Larry, would it be a problem to implement something like:
> > 
> > alan@wherever$ echo 'rq unidiff for {1.967,1.968} of typhoon/typhoon-2.4'| \
> > 	mail diffmail@bkbits.net
> 
> Sure, you can do it.
> 
> 	bk clone bk://typhoon.bkbits.net/typhoon-2.4
> 	cd typhoon-2.4
> 	bk export -tpatch -r1.967,1.968 | mail alan@lxorguk.ukuu.org.uk

Oh, was I asking whether *I* could do this?
Is my memory failing me so horribly?

No really, I can't see why you have decided to ignore this feature
request already in its embryo stage.  It would be very useful IMHO.

-- 
Tomas Szepe <szepe@pinerecords.com>
