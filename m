Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTFOBAf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFOBAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:00:35 -0400
Received: from smtp.terra.es ([213.4.129.129]:9076 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S261678AbTFOBAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:00:34 -0400
Date: Sun, 15 Jun 2003 03:14:21 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm9
Message-Id: <20030615031421.1ed6640a.diegocg@teleline.es>
In-Reply-To: <20030613013337.1a6789d9.akpm@digeo.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003 01:33:37 -0700
Andrew Morton <akpm@digeo.com> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm9/


I had the following messages: (ide, ext3 without any option, SMP, AS, JBD
debugging enabled):

VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
anticipatory scheduling elevator
[...]
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
[...]
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda5, internal journal
[...]

__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
PPP: VJ decompression error
PPP: VJ decompression error
PPP: VJ decompression error
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
__mark_inode_dirty: this cannot happen
invalid via82xx_cur_ptr, using last valid pointer
invalid via82xx_cur_ptr, using last valid pointer
invalid via82xx_cur_ptr, using last valid pointer
PPP: VJ decompression error
