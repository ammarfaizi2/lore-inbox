Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTJVKSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 06:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTJVKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 06:18:10 -0400
Received: from intra.cyclades.com ([64.186.161.6]:50399 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263479AbTJVKSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 06:18:07 -0400
Date: Wed, 22 Oct 2003 08:14:22 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: highmem problems (fwd)
Message-ID: <Pine.LNX.4.44.0310220813220.1550-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So Neil informs that he is doing fine with HIGHMEM and 2.4.23-pre.

Thank you Andrea!

---------- Forwarded message ----------
Date: Wed, 22 Oct 2003 08:53:59 +1000
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: highmem problems

On Tuesday October 21, neilb@cse.unsw.edu.au wrote:
> On Monday October 20, marcelo.tosatti@cyclades.com wrote:
> > 
> > Neil, 
> > 
> > Have you tried 2.4.23-pre ? 
> > 
> > The VM is now doing saner highmem balancing.
> 
> I've just booted into pre7 now.  Initial results are promising but it
> is too early to be sure.  I'll let you know in 24 hours.

As promised....

 24 hours later, 2.4.23-pre7 is running very happily using all 4Gig of
 RAM and not showing any inappropriate pressure on the dentry cache.

Thanks,
NeilBrown


