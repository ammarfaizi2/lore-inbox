Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWGZO3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWGZO3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWGZO3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:29:33 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932097AbWGZO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:29:32 -0400
Date: Wed, 26 Jul 2006 16:29:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: David Lang <dlang@digitalinsight.com>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Message-ID: <20060726142932.GE23701@stusta.de>
References: <20060725034247.GA5837@kroah.com> <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz> <20060726130207.GC23701@stusta.de> <200607261510.03098.adq_dvb@lidskialf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607261510.03098.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 03:10:02PM +0100, Andrew de Quincey wrote:
> On Wednesday 26 July 2006 14:02, Adrian Bunk wrote:
>...
> > What bothers me more is that noone tested this patch against the kernel
> > it was applied against.
> >
> > The submitter didn't test it works (he didn't even test the compilation).
> 
> Yes I did - I didn't test the final generated patch unfortunately since I 
> assumed it worked. The kernel I _meant_ to diff against worked perfectly :(

Sorry if this was wrong, it wasn't meant against you personally.

Things do go wrong. That's life.
And you aren't the first person who sent a patch that broke the 
compilation of the next -stable kernel.

The real problem is:
How do we get some testing coverage of -stable kernels by users to catch 
issues?
And compile errors are the least of my worries.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

