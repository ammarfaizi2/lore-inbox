Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTEPHSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 03:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTEPHSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 03:18:31 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:61904 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S264358AbTEPHSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 03:18:30 -0400
Date: Fri, 16 May 2003 09:27:54 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <hermes@gibson.dropbear.id.au>,
       Andrew Morton <akpm@digeo.com>, jt@hpl.hp.com, jt@bougret.hpl.hp.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, breed@almaden.ibm.com,
       achirica@ttd.net, jkmaline@cc.hut.fi
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030516072754.GA14661@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030514233235.GA11581@bougret.hpl.hp.com> <20030514163826.6459cd93.akpm@digeo.com> <20030515010459.GC23670@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515010459.GC23670@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 11:04:59AM +1000, David Gibson wrote:
> On Wed, May 14, 2003 at 04:38:26PM -0700, Andrew Morton wrote:
> > Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:
> > >
> > > firmwares blobs 
> > 
> > well for the purposes of tracking 2.6 activities I'll separate this issue
> > of firmware access policy out from drivers/net/wireless/. 
> > 
> > yeah, it would be nice if the core kernel provided a "give me my firmware"
> > API or something.
> 
> Well, Manuel Estrada (also author of the orinoco USB patches) has
> proposed one on lkml.  Doesn't look like people were happy with that
> version, but I think he's still working on revising it based on
> feedback.

 Yep, I posted it yesterday. Please provide feedback so I can get it
 "right (TM)" and it gets in the kernel for all to enjoy.

 Thanks

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
