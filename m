Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWKUVll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWKUVll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031440AbWKUVll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:41:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33802 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031441AbWKUVlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:41:40 -0500
Date: Tue, 21 Nov 2006 22:41:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Pavel Emelianov <xemul@openvz.org>, mingo@redhat.com, dev@sw.ru
Subject: Re: 2.6.19-rc6: known regressions (v4)
Message-ID: <20061121214140.GU5200@stusta.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <20061121213335.GB30010@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121213335.GB30010@in.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 04:33:35PM -0500, Vivek Goyal wrote:
> On Tue, Nov 21, 2006 at 10:24:24PM +0100, Adrian Bunk wrote:
> > This email lists some known regressions in 2.6.19-rc6 compared to 2.6.18
> > that are not yet fixed in Linus' tree.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> > 
> > 
> > Subject    : kernel hangs when booting with irqpoll
> > References : http://lkml.org/lkml/2006/11/20/233
> > Submitter  : Vivek Goyal <vgoyal@in.ibm.com>
> > Caused-By  : Pavel Emelianov <xemul@openvz.org>
> >              commit f72fa707604c015a6625e80f269506032d5430dc
> > Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
> > Status     : problem is being debugged
> > 
> 
> Adrian,
> 
> Pavel already provided a fix for this issue.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116409933100117&w=2

Thanks for the information, I missed this patch.

> Thanks
> Vivek

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

