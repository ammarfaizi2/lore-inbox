Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVFDSvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFDSvE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFDSvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 14:51:04 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261413AbVFDSue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 14:50:34 -0400
Date: Sat, 4 Jun 2005 20:50:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
Message-ID: <20050604185028.GZ4992@stusta.de>
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com> <42A1E96C.6080806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A1E96C.6080806@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 01:48:28PM -0400, Jeff Garzik wrote:
> Greg Stark wrote:
> >Jeff Garzik <jgarzik@pobox.com> writes:
> >
> >
> >>Several updates to the libata-dev.git repository.  Some of the branches 
> >>have
> >>been folded into a new upstream-2.6.13 branch, which holds several 
> >>changes (see
> >>attached).  Other branches were updated to the most recent kernel, which
> >>contained doc updates that caused some minor merge conflicts.
> >>
> >>I haven't yet updated 'passthru' and 'chs-support' branches to the latest
> >>kernel.
> >>
> >>Git Repository URL:
> >>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> >>
> >>List of branches:
> >>adma          chs-support  master    pdc2027x           sleeping-eh
> >>adma-mwi      iomap        ncq       promise-sata-pata  upstream-2.6.13
> >>atapi-enable  iomap-step1  passthru  sil24
> >
> >
> >Are there diffs downloadable for these? In particular I'm looking for
> >passthru. I'm imagining that with passthru SMART works?
> 
> You'll need to generate the diffs yourself, I'm afraid.

I haven't tried git, but is there really no way to tell git to do
"For every branch, generate a diff against Linus' tree" ?

This together with making them available at some URL would make life 
easier for some people.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

