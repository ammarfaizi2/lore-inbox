Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266707AbUGKSRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266707AbUGKSRg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 14:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUGKSRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 14:17:36 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:45716 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S266707AbUGKSRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 14:17:33 -0400
Message-Id: <6.1.1.1.0.20040711120748.041c8e60@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sun, 11 Jul 2004 12:17:32 -0600
To: Adrian Bunk <bunk@fs.tum.de>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: RFC: [2.6 patch] remove UMSDOS
Cc: Matija Nalis <mnalis-umsdos@voyager.hr>, linux-kernel@vger.kernel.org,
       mnalis-umsdos2@voyager.hr
In-Reply-To: <20040711112821.GC4701@fs.tum.de>
References: <20040711112821.GC4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7/11/2004 01:28 PM +0200, Adrian Bunk wrote:
>UMSDOS in 2.6 is broken, and it seems no one needs it enough to bother 
>fixing it.

Once upon a time, everyone using any Microsoft OS used FAT, but with the 
proliferation of Windows 2000 and XP, NTFS is becoming much more 
common.  (And note that Windows folks most likely to benefit from a 
mechanism like UMSDOS are also more likely to be using NTFS rather than 
FAT.) At the same time, the need to run Linux on a system with all the disc 
space allocated for Windows is being met by Knoppix, VMware, and similar 
techniques rather than the relative kludge of actually installing Linux on 
a FAT filesystem. The days of UMSDOS are behind us.

--
Jeff Woods <kazrak+kernel@cesmail.net> 


