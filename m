Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUKMVKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUKMVKC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUKMVKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:10:02 -0500
Received: from ktv31-205-71.catv-pool.axelero.hu ([62.201.71.205]:1171 "EHLO
	melkor.bonehunter.rulez.org") by vger.kernel.org with ESMTP
	id S261177AbUKMVJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:09:43 -0500
Subject: Re: pwc driver status?
From: Gergely Nagy <algernon@bonehunter.rulez.org>
To: Jan De Luyck <lkml@kcore.org>
Cc: Gergely Nagy <algernon@bonehunter.rulez.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200411132203.32908.lkml@kcore.org>
References: <200411132134.52872.lkml@kcore.org>
	 <1100378556.16772.18.camel@melkor>  <200411132203.32908.lkml@kcore.org>
Content-Type: text/plain
Date: Sat, 13 Nov 2004 22:09:38 +0100
Message-Id: <1100380178.16772.23.camel@melkor>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-13 at 22:03 +0100, Jan De Luyck wrote:
> On Saturday 13 November 2004 21:42, Gergely Nagy wrote:
> > > There seems to be an 'official' driver, but that has been discontinued,
> > > and now there seems to be an 'unofficial' one.
> > >
> > > Is there still a working driver for 2.4/2.6? What does it support?
> >
> > Luc Saillards driver for 2.6 supports all the official and now
> > discontinued driver did, and some more. It's also licensed under the GPL
> > so won't taint your kernel. For 2.4... I'd upgrade to 2.6 >;)
> >
> 
> Unfortunately, upgrading is not an option right now for other reasons...

That's a pity... because there is no 2.4 version of Luc's driver as far
as I know :(

> Is this driver also supporting the Logitech Quickcam for Notebooks? I found 
> some references that the 'official' one used to do that, but I can't find 
> much docs... 

As far as I know, yes. The source code seems to indicate the same.

-- 
Gergely Nagy

