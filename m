Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTDWVCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDWVCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:02:03 -0400
Received: from [63.246.199.14] ([63.246.199.14]:38533 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S263567AbTDWVCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: David Brodbeck <DavidB@mail.interclean.com>,
       "'motion@lists.frogtown.com'" <motion@pdx.frogtown.com>,
       andras@t-online.de, linux-kernel@vger.kernel.org, motion@frogtown.com
Subject: Re: [Motion] Re: IDE corruption during heavy bt878-induced interr upt load [LKM]
Date: Wed, 23 Apr 2003 18:13:46 -0400
User-Agent: KMail/1.4.3
References: <C823AC1DB499D511BB7C00B0D0F0574C583D23@serverdell2200.interclean.com>
In-Reply-To: <C823AC1DB499D511BB7C00B0D0F0574C583D23@serverdell2200.interclean.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231813.46892.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this true??? Does onboard IDE controllers appear and work the same way as 
IDE or PCI controllers with respect to IRQ, DMA, and memory access?

On Wednesday 23 April 2003 03:22 pm, David Brodbeck wrote:
> > -----Original Message-----
> > From: joe briggs [mailto:jbriggs@briggsmedia.com]
> >
> > I am glad that you mentioned ext3 because while I curse
> > ReiserFS, I really
> > don't think that it is part of the problem. Definately
> > PCI-dma related, but
> > does onboard IDE (i.e., my system disk) use DMA in the same
> > way that a PCI
> > adapter such as Promise does?
>
> I'm not a hardware expert, but since on-board IDE controllers usually
> appear as PCI devices to the OS, I assume they do DMA the same way.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
