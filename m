Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRHBM0e>; Thu, 2 Aug 2001 08:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268910AbRHBM0Y>; Thu, 2 Aug 2001 08:26:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32528 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268908AbRHBM0R>; Thu, 2 Aug 2001 08:26:17 -0400
Subject: Re: 2.4.2 ext2fs corruption status
To: mhd@gxt.com (Mohamed DOLLIAZAL)
Date: Thu, 2 Aug 2001 13:27:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        adilger@turbolinux.com (Andreas Dilger), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Mohamed DOLLIAZAL" at Aug 01, 2001 09:40:44 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SHZR-0000TJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I'am sorry I forgot to mention that the filesystem corruption happened on
> SCSI disks.  I guess there is no DMA on the SCSI disks.

Well there is but its off the scsi controller so should be ok

>    Do you think that the VIA fixes that are included in the 2.4.6ac5 kernel or
> above may solve my problem.

They might do, they might not. But they are worth checking
