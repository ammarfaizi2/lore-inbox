Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTDWTKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTDWTKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:10:41 -0400
Received: from www.interclean.com ([152.160.178.8]:61320 "EHLO
	mail.interclean.com") by vger.kernel.org with ESMTP id S264436AbTDWTKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:10:39 -0400
Message-ID: <C823AC1DB499D511BB7C00B0D0F0574C583D23@serverdell2200.interclean.com>
From: David Brodbeck <DavidB@mail.interclean.com>
To: "'motion@lists.frogtown.com'" <motion@mailhost.frogtown.com>,
       andras@t-online.de, linux-kernel@vger.kernel.org, motion@frogtown.com
Subject: RE: [Motion] Re: IDE corruption during heavy bt878-induced interr
	upt load [LKM]
Date: Wed, 23 Apr 2003 15:22:32 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: joe briggs [mailto:jbriggs@briggsmedia.com]

> I am glad that you mentioned ext3 because while I curse 
> ReiserFS, I really 
> don't think that it is part of the problem. Definately 
> PCI-dma related, but 
> does onboard IDE (i.e., my system disk) use DMA in the same 
> way that a PCI 
> adapter such as Promise does? 

I'm not a hardware expert, but since on-board IDE controllers usually appear
as PCI devices to the OS, I assume they do DMA the same way.
