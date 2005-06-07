Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVFGNFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVFGNFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVFGNFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:05:45 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:20051 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261797AbVFGNFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:05:36 -0400
Date: Tue, 7 Jun 2005 15:05:35 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050607130535.GD16602@harddisk-recovery.com>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 11:08:25AM -0700, Linus Torvalds wrote:

Over here the script can get the  correct information from git
branches:

> Jeff Garzik:
>   Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix

But for your own changes it seems to fail:

> Linus Torvalds:
>   Linux 2.6.12-rc6
>   Automatic merge of 'misc-fixes' branch from

... from what?

>   Automatic merge of rsync://www.parisc-linux.org/~jejb/git/scsi-for-linus-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6

And this again works.

>   Merge of 'docs' branch from
>   Merge of master.kernel.org:/.../aegl/linux-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../sfrench/cifs-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../davem/sparc-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../gregkh/usb-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../gregkh/i2c-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../gregkh/pci-2.6
>   Automatic merge of rsync://rsync.kernel.org/.../aegl/linux-2.6
>   Merge of rsync://rsync.kernel.org/.../davem/tg3-2.6
>   Automatic merge of 'misc-fixes' branch from
>   Automatic merge of 'for-linus' branch from
>   Automatic merge of rsync://rsync.kernel.org/.../hch/xfs-2.6
>   ide-cd: revert DMA mask test change
>   Automatic merge of rsync://rsync.kernel.org/.../davem/net-2.6
>   Automatic merge of 'for-linus' branch from
>   Merge of 'misc-fixes' branch from
>   Merge of rsync://rsync.kernel.org/.../davem/sparc-2.6
>   Merge of 'new-ids' branch from
>   Merge of 'for-linus' branch from

I don't see what's going wrong, maybe you can figure out.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
