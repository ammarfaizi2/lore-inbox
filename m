Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293752AbSB1UyH>; Thu, 28 Feb 2002 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293744AbSB1Uwg>; Thu, 28 Feb 2002 15:52:36 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:53519 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S293741AbSB1UuB>; Thu, 28 Feb 2002 15:50:01 -0500
Message-ID: <3C7E96D7.1000904@megapathdsl.net>
Date: Thu, 28 Feb 2002 12:45:11 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020217
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: 2.5.5-dj2 -- Unresolved symbol dparent_lock in fat.o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.5-dj2 + nls.patch + migrate.diff + console_8.diff
+ roberto nibaldo's patches:

depmod: *** Unresolved symbols in /lib/modules/2.5.5-dj2/kernel/fs/fat/fat.o
depmod: 	dparent_lock

CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m

