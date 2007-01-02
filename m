Return-Path: <linux-kernel-owner+w=401wt.eu-S964947AbXABTe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbXABTe1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbXABTe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:34:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2455 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964947AbXABTe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:34:26 -0500
Date: Tue, 2 Jan 2007 20:34:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Robert Hancock <hancockr@shaw.ca>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@osdl.org,
       Jean Delvare <khali@linux-fr.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Marcel Holtmann <marcel@holtmann.org>,
       bluez-devel@lists.sourceforge.net, Rene Herman <rene.herman@gmail.com>,
       Mark Lord <lkml@rtr.ca>, Laurent Riffard <laurent.riffard@free.fr>,
       Christoph Hellwig <hch@lst.de>, petero2@telia.com
Subject: Re: 2.6.20-rc3: known regressions with patches available (part 1)
Message-ID: <20070102193429.GX20714@stusta.de>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <20070102192449.GV20714@stusta.de> <20070102192651.GM2483@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102192651.GM2483@kernel.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 08:26:52PM +0100, Jens Axboe wrote:
> On Tue, Jan 02 2007, Adrian Bunk wrote:
> > Subject    : CFQ disk throughput halved
> > References : http://lkml.org/lkml/2007/01/1/104
> > Submitter  : Rene Herman <rene.herman@gmail.com>
> >              Mark Lord <lkml@rtr.ca>
> > Caused-By  : Jens Axboe <jens.axboe@oracle.com>
> >              commit 719d34027e1a186e46a3952e8a24bf91ecc33837
> > Handled-By : Jens Axboe <jens.axboe@oracle.com>
> > Patch      : http://lkml.org/lkml/2007/1/2/75
> > Status     : patch available
> 
> Patch is already merged in -git.

Thanks for this information, I missed this (as well as the merged SATA 
fix) since it isn't yet at the git mirrors.

> Jens Axboe

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

