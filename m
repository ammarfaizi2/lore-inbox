Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUGKUSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUGKUSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUGKUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:18:16 -0400
Received: from hera.kernel.org ([63.209.29.2]:47241 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266648AbUGKUSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:18:07 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: RFC: [2.6 patch] remove UMSDOS
Date: Sun, 11 Jul 2004 20:17:43 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccs797$bd3$1@terminus.zytor.com>
References: <20040711112821.GC4701@fs.tum.de> <6.1.1.1.0.20040711120748.041c8e60@no.incoming.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089577063 11684 127.0.0.1 (11 Jul 2004 20:17:43 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 11 Jul 2004 20:17:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <6.1.1.1.0.20040711120748.041c8e60@no.incoming.mail>
By author:    Jeff Woods <Kazrak+kernel@cesmail.net>
In newsgroup: linux.dev.kernel
>
> At 7/11/2004 01:28 PM +0200, Adrian Bunk wrote:
> >UMSDOS in 2.6 is broken, and it seems no one needs it enough to bother 
> >fixing it.
> 
> Once upon a time, everyone using any Microsoft OS used FAT, but with the 
> proliferation of Windows 2000 and XP, NTFS is becoming much more 
> common.  (And note that Windows folks most likely to benefit from a 
> mechanism like UMSDOS are also more likely to be using NTFS rather than 
> FAT.) At the same time, the need to run Linux on a system with all the disc 
> space allocated for Windows is being met by Knoppix, VMware, and similar 
> techniques rather than the relative kludge of actually installing Linux on 
> a FAT filesystem. The days of UMSDOS are behind us.
> 

Realistically I think it's VFAT that killed it.

	-hpa
