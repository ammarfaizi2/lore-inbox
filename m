Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265161AbSJRPG3>; Fri, 18 Oct 2002 11:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265162AbSJRPG2>; Fri, 18 Oct 2002 11:06:28 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:56807 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265161AbSJRPG1> convert rfc822-to-8bit; Fri, 18 Oct 2002 11:06:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Sat, 19 Oct 2002 01:21:09 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <15355.1034859667@ocs3.intra.ocs.com.au> <200210190014.19357.harisri@bigpond.com> <20021018145204.GG23930@dualathlon.random>
In-Reply-To: <20021018145204.GG23930@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210190121.09577.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Saturday 19 October 2002 00:52, Andrea Arcangeli wrote:
> if you still have the .config used to build the kernel please send it
> too, thanks!

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG8=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_1GB=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_BLK_DEV_FD=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_PPP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

> I've no idea why radeon or agpgart could generate corruption in my tree
> and not in mainline and I can't reproduce. the best would be if you
> could do a binary search on all the patches applied (first applying all
> the [012]* and see if you can rerproduce, and so on)

I will try that.

Thanks
-- 
Hari
harisri@bigpond.com

