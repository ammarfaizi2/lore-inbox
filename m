Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTEMRwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTEMRws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:52:48 -0400
Received: from havoc.daloft.com ([64.213.145.173]:24791 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263264AbTEMRwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:52:15 -0400
Date: Tue, 13 May 2003 14:05:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513180459.GB11073@gtf.org>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de> <20030513180020.GB3309@suse.de> <20030513180334.GJ17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513180334.GJ17033@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:03:34PM +0200, Jens Axboe wrote:
> On Tue, May 13 2003, Dave Jones wrote:
> > On Tue, May 13, 2003 at 08:40:59AM +0200, Jens Axboe wrote:
> >  > > Weird.  Mine doesn't seem to assert it, nor does the identify page
> >  > > indicate it's supported.  Maybe I have a broken drive firmware.
> >  > 
> >  > Then the linux code won't work on it, have you tried? I've tried a lot
> >  > of different IBM models, they all do service interrupts just fine.
> > 
> > bug in the firmware version on Jeffs drives perhaps ?
> 
> It's possible, it would help a lot of Jeff would answer the question
> above and maybe even share what drive he is using with us.

hehe, just did (answer: no).  I'll post hdparm -I for it tomorrow.

	Jeff



