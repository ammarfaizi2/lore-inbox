Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbULAXVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbULAXVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbULAXVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:21:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36233 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261489AbULAXVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:21:40 -0500
Date: Wed, 1 Dec 2004 15:23:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Auke Kok <sofar@lunar-linux.org>, linux-kernel@vger.kernel.org,
       vortex@scyld.com
Subject: Re: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
Message-ID: <20041201172318.GK2250@dmt.cyclades>
References: <41AE2661.2040408@lunar-linux.org> <20041201131127.208e15b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201131127.208e15b6.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 01:11:27PM -0800, Andrew Morton wrote:
> Auke Kok <sofar@lunar-linux.org> wrote:
> >
> > 
> > This message is a confirmation on the thread by:
> > 
> > From: Andreas Haumer
> > Date: Tue Sep 21 2004 - 04:16:52 EST
> > Subject: [PATCH][2.4.28-pre3] 3c59x builtin NIC on Asus Pundit-R
> > 
> > I have 24 boxes with the same hardware and all require the patch 
> > attached to Andreas' e-mail to function. After abusing one of them for 2 
> > days continuously the nic hasn't shown a single flaw so far ;^)
> > 
> > I thus would like to conclude that this patch is a valid and worthfull 
> > addition to the 2.4.28+ kernels, as it applies cleanly to 2.4.28-final.
> > 
> > Auke kok
> > 
> > 
> > PS URL to the patch: 
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1215/013-3com_ati_radeon.patch
> 
> That patch should of course be merged.  Please email a copy to Marcelo.

This has been merged together with 3c59x's v2.6 sync in 2.4.29-pre1.
Can you give that a shot Auke?
