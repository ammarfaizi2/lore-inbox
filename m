Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291504AbSBMKLS>; Wed, 13 Feb 2002 05:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291492AbSBMKLC>; Wed, 13 Feb 2002 05:11:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61702 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291485AbSBMKKu>; Wed, 13 Feb 2002 05:10:50 -0500
Subject: Re: 2.5.4 sound module problem
To: davem@redhat.com (David S. Miller)
Date: Wed, 13 Feb 2002 10:24:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, ac9410@bellsouth.net, alan@clueserver.org,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020213.013644.118972487.davem@redhat.com> from "David S. Miller" at Feb 13, 2002 01:36:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16awaG-0004sB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    There are PCI drivers using the old sound code. Whether it matters is a 
>    more complicated question as these devices use ISA DMA emulation or their
>    own pseudo DMA functionality.
>    
> The sound layer PCI DMA stuff like a nice project for some kernel
> janitors :-))

Waste of effort. ALSA will replace the OSS code anyway
