Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTEMRvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTEMRvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:51:11 -0400
Received: from havoc.daloft.com ([64.213.145.173]:21207 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263295AbTEMRvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:51:10 -0400
Date: Tue, 13 May 2003 14:03:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>, Jens Axboe <axboe@suse.de>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513180354.GA11073@gtf.org>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org> <20030513064059.GL17033@suse.de> <20030513180020.GB3309@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513180020.GB3309@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 07:00:20PM +0100, Dave Jones wrote:
> On Tue, May 13, 2003 at 08:40:59AM +0200, Jens Axboe wrote:
>  > > Weird.  Mine doesn't seem to assert it, nor does the identify page
>  > > indicate it's supported.  Maybe I have a broken drive firmware.
>  > 
>  > Then the linux code won't work on it, have you tried? I've tried a lot
>  > of different IBM models, they all do service interrupts just fine.
> 
> bug in the firmware version on Jeffs drives perhaps ?

I'll check it out.  The answer to Jens' question is no, I've haven't
tried his TCQ stuff on this drive yet.  Just poked and prodded it a lot
on my own :)

	Jeff



