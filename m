Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265005AbRGEMa4>; Thu, 5 Jul 2001 08:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264998AbRGEMar>; Thu, 5 Jul 2001 08:30:47 -0400
Received: from ns1.actimage.fr ([194.79.162.35]:42546 "EHLO ns1.actimage.fr")
	by vger.kernel.org with ESMTP id <S264993AbRGEMa2>;
	Thu, 5 Jul 2001 08:30:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Unresolved symbols since 2.4.5 ?
From: Cyril ADRIAN <c.adrian@alplog.fr>
Date: 05 Jul 2001 14:32:21 +0200
Message-ID: <873d8b4kve.fsf@galaxie.alplog.net>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello,

    Sorry for this  long message but I  really need your help. I  hope I'm not
off-topic. Maybe am I doing something wrong?

    In short, since  2.4.5 I seem not  to be able to install  a kernel (depmod
says "unresolved  symbols").  2.4.6  shows the  same problem but  as far  as I
remember  2.4.4 did  not.   The sources  I  use are  downloaded  straight from
www.kernel.org and I always use the same .config file.

    Relevant data  about my machine: PC  Pentium III, 320 Mo,  UDMA disks, and
the OS is Debian GNU/Linux 2.2r3 ("Potato"). Currently I run a 2.4.1 kernel.

    To  compile  the kernel,  I  run  "make-kpkg  buildpackage" (make-kpkg  is
provided by Debian  to automatically compile and build  debian packages out of
the kernel source).

    If you  have any questions  please feel free  to ask. I'm willing  to help
improve Linux, not to bother you.

    Thanks from your help,

        Cyril

PS- Would you be kind and Cc: to c.adrian@alplog.fr? Thanks a lot.


----8<---- (trace)
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/arch/i386/kernel/cpuid.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/arch/i386/kernel/microcode.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/arch/i386/kernel/msr.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/block/loop.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/block/nbd.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/atixlmouse.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/busmouse.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/logibusmouse.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/msbusmouse.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/nvram.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/pc110pad.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/qpmouse.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/rtc.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/char/serial.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c501.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c503.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c505.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c507.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c509.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c515.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/3c59x.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/8390.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/net/dummy.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/parport/parport.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/parport/parport_pc.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/pnp/isa-pnp.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/scsi/ide-scsi.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/scsi/scsi_mod.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/drivers/scsi/sg.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/autofs4/autofs4.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/binfmt_aout.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/binfmt_misc.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/coda/coda.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/isofs/isofs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/lockd/lockd.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/minix/minix.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/msdos/msdos.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/nfs/nfs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/nfsd/nfsd.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/nls/nls_cp437.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/nls/nls_cp850.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/nls/nls_iso8859-1.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/nls/nls_iso8859-15.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/ntfs/ntfs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/ramfs/ramfs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/reiserfs/reiserfs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/smbfs/smbfs.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/udf/udf.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/fs/vfat/vfat.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/net/ipv4/ip_gre.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/net/ipv4/ipip.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/net/ipx/ipx.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/net/netlink/netlink_dev.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/net/packet/af_packet.o
depmod: *** Unresolved symbols in /lib/modules/2.4.6/kernel/net/sunrpc/sunrpc.o
---->8----

----8<---- (grep '=\(y\|m\)' .config)
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPX=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m
CONFIG_INTEL_RNG=y
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
---->8----

-- 
Cyril ADRIAN                                   ALPLOG F-67400 ILLKIRCH
+33 (0)6 70 55 10 60                              +33 (0)3 90 40 00 00
mailto:cadrian@ifrance.com                   mailto:c.adrian@alplog.fr
http://sourceforge.net/projects/smerge            http://www.alplog.fr
