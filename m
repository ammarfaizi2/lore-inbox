Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbSLFVOU>; Fri, 6 Dec 2002 16:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbSLFVOT>; Fri, 6 Dec 2002 16:14:19 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:15627 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267628AbSLFVOS>; Fri, 6 Dec 2002 16:14:18 -0500
Date: Fri, 6 Dec 2002 21:21:53 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
In-Reply-To: <20021206195007.A12702@infradead.org>
Message-ID: <Pine.LNX.4.44.0212062120240.10225-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hi!
> > 
> >   I have a new patch avaiable. It is against 2.5.50. The patch is at 
> 
> Any chance you could sync with linus again?  fb in mainline is pretty
> rotten..

I think the time has come. Alot of improvmenents have happened :-) The 
final api for the low level drivers is done. Any further changes will be 
in fbmem.c and fbcon. I just synced up the latest work. 



