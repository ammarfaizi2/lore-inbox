Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291392AbSBHEC5>; Thu, 7 Feb 2002 23:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291393AbSBHECr>; Thu, 7 Feb 2002 23:02:47 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15109
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291392AbSBHECf>; Thu, 7 Feb 2002 23:02:35 -0500
Date: Thu, 7 Feb 2002 19:53:11 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Skip Ford <skip.ford@verizon.net>
cc: linux-kernel@vger.kernel.org, garzik@havoc.gtf.org
Subject: Re: Alpha update for 2.5.3
In-Reply-To: <20020208015826.JIFG11848.out009.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.10.10202071952340.15165-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That code path will go away!
That is a diagnostic path only.

On Thu, 7 Feb 2002, Skip Ford wrote:

> Jeff Garzik wrote:
> > 
> > Second comment, some of the bits in your patch are in 2.5.3-pre3.  [but
> > drivers/ide/ide-dma.c does not compile for me, unrelated to alpha...]
> 
> This patch Jens posted seems to fix it.
> 
> -- 
> Skip
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

