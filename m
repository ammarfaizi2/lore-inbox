Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131017AbRAKXWX>; Thu, 11 Jan 2001 18:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRAKXWN>; Thu, 11 Jan 2001 18:22:13 -0500
Received: from smtp2.libero.it ([193.70.192.52]:4034 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S131017AbRAKXWG>;
	Thu, 11 Jan 2001 18:22:06 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Fri, 12 Jan 2001 00:18:22 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  charset="US-ASCII";
  boundary="------------Boundary-00=_M2U0LWWUG9R0272IME5O"
Cc: <andre@linux-ide.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.31.0101112024250.9238-100000@neptun.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.31.0101112024250.9238-100000@neptun.fachschaften.tu-muenchen.de>
Subject: 2.4.0 Keyboard and mouse lock
MIME-Version: 1.0
Message-Id: <01011200182200.00925@af>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_M2U0LWWUG9R0272IME5O
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: 8bit

I don't know if it's the 2.4.0 I installed since few days, but before I never 
seen that on my PC.

The PC (RH 6.2 + updates), looked fully freezed and Sysreq didn't
work. I had a Netscape window on my screen. The mouse didn't move.

I login without problem from another PC. I tried to kill the X server, but 
without issue, it is the server died, but the screen, the keyboard and the 
mouse stayed in the same unusable state.

The reboot was OK. If that could be of interested I attach the part of 
/var/log/message (p file) since the boot previous such keyboard and mouse 
lock and the .configure of my 2.4.0.

	Andrea
--------------Boundary-00=_M2U0LWWUG9R0272IME5O
Content-Type: text/plain;
  name=".config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_ISA=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=3Dy
# CONFIG_M686FXSR is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=3Dy
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=3Dm
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_MTRR=3Dy
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
# CONFIG_VISWS is not set
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
CONFIG_PM=3Dy
# CONFIG_ACPI is not set
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=3Dy
# CONFIG_MD_RAID5 is not set
CONFIG_MD_BOOT=3Dy
CONFIG_AUTODETECT_RAID=3Dy
CONFIG_BLK_DEV_LVM=3Dm
CONFIG_LVM_PROC_FS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK=3Dy
CONFIG_RTNETLINK=3Dy
CONFIG_NETLINK_DEV=3Dy
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_RTNETLINK=3Dy
CONFIG_NETLINK=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=3Dy
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_COMPAT_IPCHAINS=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_COMPAT_IPFWADM=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IPV6=3Dm
CONFIG_IPV6_EUI64=3Dy
# CONFIG_IPV6_NO_PB is not set

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
CONFIG_KHTTPD=3Dm
# CONFIG_ATM is not set

#
# =20
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NETLINK=3Dy
CONFIG_RTNETLINK=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy

#
# Telephony Support
#
CONFIG_PHONE=3Dm
CONFIG_PHONE_IXJ=3Dm

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_PIIX_TUNING=3Dy
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=3Dy
CONFIG_PDC202XX_BURST=3Dy
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_TUN=3Dm
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=3Dy
# CONFIG_8139TOO is not set
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dy
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_ASYNC=3Dy
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPP_BSDCOMP=3Dy
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
CONFIG_LP_CONSOLE=3Dy
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#

#
# Game port support
#

#
# Gameport joysticks
#

#
# Serial port support
#

#
# Serial port joysticks
#

#
# Parallel port joysticks
#
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=3Dy
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_I810_TCO is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
CONFIG_DRM=3Dy
CONFIG_DRM_TDFX=3Dy
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=3Dy
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dy
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS_VERBOSE=3D0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-15"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dy
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=3Dm
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=3Dy
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_UTF8=3Dm

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=3Dy
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=3Dy
CONFIG_SOUND_TRACEINIT=3Dy
CONFIG_SOUND_DMAP=3Dy
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=3Dm
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=3Dm
CONFIG_SOUND_OPL3SA1=3Dm
CONFIG_SOUND_OPL3SA2=3Dm
CONFIG_SOUND_YMPCI=3Dm
CONFIG_SOUND_UART6850=3Dm
# CONFIG_SOUND_AEDSP16 is not set

#
# USB support
#
CONFIG_USB=3Dy
CONFIG_USB_DEBUG=3Dy

#
# Miscellaneous USB options
#
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set

#
# USB Controllers
#
CONFIG_USB_UHCI_ALT=3Dy
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#

#
#   Input core support is needed for USB HID
#

#
# USB Imaging devices
#
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=3Dy

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# USB Network adaptors
#
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB misc drivers
#
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=3Dy

--------------Boundary-00=_M2U0LWWUG9R0272IME5O
Content-Type: text/english;
  name="p"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="p"

Jan 10 23:24:04 af syslogd 1.3-3: restart.
Jan 10 23:24:04 af syslog: syslogd startup succeeded
Jan 10 23:24:04 af kernel: klogd 1.3-3, log source =3D /proc/kmsg started=
=2E
Jan 10 23:24:04 af syslog: klogd startup succeeded
Jan 10 23:24:04 af kernel: Inspecting /boot/System.map
Jan 10 23:24:04 af kernel: Symbol table has incorrect version number.=20
Jan 10 23:24:04 af kernel: Cannot find map file.
Jan 10 23:24:04 af kernel: Loaded 29 symbols from 3 modules.
Jan 10 23:24:04 af kernel: Linux version 2.4.0 (root@af) (gcc version egc=
s-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Sun Jan 7 02:35:31 CET =
2001=20
Jan 10 23:24:04 af kernel: BIOS-provided physical RAM map:=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 000000000009e400 @ 000000000000000=
0 (usable)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000000001c00 @ 000000000009e40=
0 (reserved)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000000018c00 @ 00000000000e740=
0 (reserved)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000003ffdc00 @ 000000000010000=
0 (usable)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000000001c00 @ 00000000040fdc0=
0 (ACPI data)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000000000400 @ 00000000040ff80=
0 (ACPI NVS)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000003f00400 @ 00000000040ffc0=
0 (usable)=20
Jan 10 23:24:04 af kernel:  BIOS-e820: 0000000000018c00 @ 00000000fffe740=
0 (reserved)=20
Jan 10 23:24:05 af identd: identd startup succeeded
Jan 10 23:24:05 af kernel: Scan SMP from c0000000 for 1024 bytes.=20
Jan 10 23:24:05 af kernel: Scan SMP from c009fc00 for 1024 bytes.=20
Jan 10 23:23:56 af rc.sysinit: Mounting proc filesystem succeeded=20
Jan 10 23:24:05 af kernel: Scan SMP from c00f0000 for 65536 bytes.=20
Jan 10 23:24:05 af crond: crond startup succeeded
Jan 10 23:23:56 af sysctl: net.ipv4.ip_forward =3D 0=20
Jan 10 23:24:05 af kernel: Scan SMP from c009f400 for 4096 bytes.=20
Jan 10 23:23:56 af sysctl: net.ipv4.conf.all.rp_filter =3D 1=20
Jan 10 23:24:06 af kernel: On node 0 totalpages: 32768=20
Jan 10 23:24:06 af kernel: zone(0): 4096 pages.=20
Jan 10 23:24:06 af kernel: zone(1): 28672 pages.=20
Jan 10 23:24:06 af snort: Initializing daemon mode
Jan 10 23:24:06 af modprobe: modprobe: Can't locate module ppp0
Jan 10 23:24:06 af kernel: zone(2): 0 pages.=20
Jan 10 23:23:56 af sysctl: kernel.sysrq =3D 0=20
Jan 10 23:24:06 af snortd: snort startup succeeded
Jan 10 23:24:06 af snort: ERROR: OpenPcap() device ppp0 open:  ^Iioctl: N=
o such device=20
Jan 10 23:24:06 af kernel: mapped APIC to ffffe000 (01223000)=20
Jan 10 23:23:56 af sysctl: error: 'net.ipv4.ip_always_defrag' is an unkno=
wn key=20
Jan 10 23:24:07 af kernel: Kernel command line: BOOT_IMAGE=3Dl2.4 ro root=
=3D901=20
Jan 10 23:23:56 af rc.sysinit: Configuring kernel parameters succeeded=20
Jan 10 23:24:08 af kernel: Initializing CPU#0=20
Jan 10 23:23:56 af date: Wed Jan 10 23:23:55 CET 2001=20
Jan 10 23:24:08 af sshd: Starting sshd:=20
Jan 10 23:24:08 af kernel: Detected 233.294 MHz processor.=20
Jan 10 23:23:56 af rc.sysinit: Setting clock : Wed Jan 10 23:23:55 CET 20=
01 succeeded=20
Jan 10 23:24:09 af sshd: sshd startup succeeded
Jan 10 23:24:09 af sshd[571]: Server listening on 0.0.0.0 port 22.
Jan 10 23:24:09 af kernel: Console: colour VGA+ 80x50=20
Jan 10 23:23:56 af rc.sysinit: Loading default keymap succeeded=20
Jan 10 23:24:09 af sshd: ^[[60G
Jan 10 23:24:09 af sshd[571]: Generating 768 bit RSA key.
Jan 10 23:24:09 af kernel: Calibrating delay loop... 465.30 BogoMIPS=20
Jan 10 23:23:56 af swapon: swapon: cannot stat /mnt/e/swp_file: No such f=
ile or directory=20
Jan 10 23:24:09 af sshd:=20
Jan 10 23:24:09 af kernel: Memory: 126680k/131072k available (987k kernel=
 code, 3988k reserved, 377k data, 196k init, 0k highmem)=20
Jan 10 23:23:56 af rc.sysinit: Activating swap partitions failed=20
Jan 10 23:24:09 af rc: Starting sshd succeeded
Jan 10 23:24:09 af kernel: Dentry-cache hash table entries: 16384 (order:=
 5, 131072 bytes)=20
Jan 10 23:23:56 af rc.sysinit: Setting hostname af succeeded=20
Jan 10 23:24:09 af keytable: Loading keymap:=20
Jan 10 23:24:09 af kernel: Buffer-cache hash table entries: 8192 (order: =
3, 32768 bytes)=20
Jan 10 23:23:56 af fsck: /dev/md1: clean, 107593/346368 files, 464668/692=
464 blocks=20
Jan 10 23:24:10 af kernel: Page-cache hash table entries: 32768 (order: 5=
, 131072 bytes)=20
Jan 10 23:23:56 af rc.sysinit: Checking root filesystem succeeded=20
Jan 10 23:24:10 af keytable: Loading system font:=20
Jan 10 23:24:10 af kernel: Inode-cache hash table entries: 8192 (order: 4=
, 65536 bytes)=20
Jan 10 23:23:56 af isapnp: Board 1 has Identity a9 10 08 4d 2e 2b 00 8c 0=
e:  CTL002b Serial No 268979502 [checksum a9]=20
Jan 10 23:24:10 af sshd[571]: RSA key generation complete.
Jan 10 23:24:10 af keytable: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.=
kmap.gz
Jan 10 23:24:10 af kernel: VFS: Diskquotas version dquot_6.4.0 initialize=
d=20
Jan 10 23:23:56 af isapnp: CTL002b/268979502[0]{Audio               }: Po=
rts 0x220 0x330; IRQ5 DMA1 DMA5 --- Enabled OK=20
Jan 10 23:24:10 af rc: Starting keytable succeeded
Jan 10 23:24:10 af kernel: CPU: Before vendor init, caps: 0080f9ff 000000=
00 00000000, vendor =3D 0=20
Jan 10 23:23:56 af isapnp: CTL002b/268979502[2]{StereoEnhance       }: Po=
rt 0x100; --- Enabled OK=20
Jan 10 23:24:10 af kernel: CPU: L1 I cache: 16K, L1 D cache: 16K=20
Jan 10 23:24:11 af postfix: Starting postfix:=20
Jan 10 23:23:56 af isapnp: CTL002b/268979502[3]{Game                }: Po=
rt 0x200; --- Enabled OK=20
Jan 10 23:24:11 af kernel: CPU: L2 cache: 512K=20
Jan 10 23:23:56 af rc.sysinit: Setting up ISA PNP devices succeeded=20
Jan 10 23:24:11 af kernel: Intel machine check architecture supported.=20
Jan 10 23:23:56 af rc.sysinit: Remounting root filesystem in read-write m=
ode succeeded=20
Jan 10 23:24:12 af kernel: Intel machine check reporting enabled on CPU#0=
=2E=20
Jan 10 23:23:58 af rc.sysinit: Finding module dependencies succeeded=20
Jan 10 23:24:12 af kernel: CPU: After vendor init, caps: 0080f9ff 0000000=
0 00000000 00000000=20
Jan 10 23:23:58 af modprobe: modprobe: Can't locate module sound-service-=
0-0=20
Jan 10 23:24:12 af kernel: CPU: After generic, caps: 0080f9ff 00000000 00=
000000 00000000=20
Jan 10 23:23:58 af rc.sysinit: Loading mixer settings succeeded=20
Jan 10 23:24:12 af kernel: CPU: Common caps: 0080f9ff 00000000 00000000 0=
0000000=20
Jan 10 23:23:58 af aumix-minimal: vol set to 61, 61=20
Jan 10 23:24:12 af kernel: CPU: Intel Pentium II (Klamath) stepping 04=20
Jan 10 23:23:58 af aumix-minimal: bass set to 75, 75=20
Jan 10 23:24:13 af kernel: Checking 'hlt' instruction... OK.=20
Jan 10 23:23:58 af aumix-minimal: treble set to 75, 75=20
Jan 10 23:24:13 af kernel: POSIX conformance testing by UNIFIX=20
Jan 10 23:23:58 af aumix-minimal: synth set to 75, 75, P=20
Jan 10 23:24:14 af kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@a=
tnf.csiro.au)=20
Jan 10 23:23:58 af aumix-minimal: pcm set to 75, 75=20
Jan 10 23:24:14 af kernel: mtrr: detected mtrr type: Intel=20
Jan 10 23:23:58 af aumix-minimal: speaker set to 75, 75=20
Jan 10 23:24:15 af kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9c4, =
last bus=3D1=20
Jan 10 23:23:58 af aumix-minimal: line set to 75, 75, P=20
Jan 10 23:24:15 af kernel: PCI: Using configuration type 1=20
Jan 10 23:23:58 af aumix-minimal: mic set to 16, 16, R=20
Jan 10 23:24:16 af kernel: PCI: Probing PCI hardware=20
Jan 10 23:23:58 af aumix-minimal: cd set to 75, 75, P=20
Jan 10 23:24:16 af kernel: Unknown bridge resource 0: assuming transparen=
t=20
Jan 10 23:23:58 af aumix-minimal: mix set to 0, 0=20
Jan 10 23:24:17 af kernel: Unknown bridge resource 1: assuming transparen=
t=20
Jan 10 23:23:58 af aumix-minimal: igain set to 75, 75=20
Jan 10 23:24:17 af kernel: Unknown bridge resource 2: assuming transparen=
t=20
Jan 10 23:23:58 af aumix-minimal: ogain set to 75, 75=20
Jan 10 23:24:18 af kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:0=
7.0=20
Jan 10 23:23:58 af fsck: /dev/md2: clean, 44659/483840 files, 372317/9658=
72 blocks=20
Jan 10 23:24:18 af kernel: Limiting direct PCI/PCI transfers.=20
Jan 10 23:23:58 af fsck: /dev/md0: clean, 31/6000 files, 5686/24000 block=
s=20
Jan 10 23:24:19 af kernel: isapnp: Scanning for Pnp cards...=20
Jan 10 23:23:58 af rc.sysinit: Checking filesystems succeeded=20
Jan 10 23:23:59 af rc.sysinit: Mounting local filesystems succeeded=20
Jan 10 23:24:20 af kernel: isapnp: SB audio device quirk - increasing por=
t range=20
Jan 10 23:23:59 af rc.sysinit: Turning on user and group quotas for local=
 filesystems succeeded=20
Jan 10 23:24:20 af kernel: isapnp: Card 'Creative SB16 PnP'=20
Jan 10 23:23:59 af rc.sysinit: Enabling swap space succeeded=20
Jan 10 23:24:20 af kernel: isapnp: 1 Plug & Play card detected total=20
Jan 10 23:23:59 af init: Entering runlevel: 5=20
Jan 10 23:24:20 af kernel: Linux NET4.0 for Linux 2.4=20
Jan 10 23:24:00 af rebootonpanic: Enabling reboot on panic...=20
Jan 10 23:24:20 af kernel: Based upon Swansea University Computer Society=
 NET3.039=20
Jan 10 23:24:00 af rc: Starting rebootonpanic succeeded=20
Jan 10 23:24:20 af kernel: Initializing RT netlink socket=20
Jan 10 23:24:00 af bastille-firewall: =20
Jan 10 23:24:21 af kernel: DMI 2.1 present.=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:21 af kernel: 46 structures occupying 1511 bytes.=20
Jan 10 23:24:21 af postfix: postfix-script: WARNING: The file /var/spool/=
postfix/etc/localtime was originally created as a copy of
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:21 af kernel: DMI table at 0x000F0560.=20
Jan 10 23:24:21 af postfix: postfix-script: /etc/localtime. They are now =
different. If you have updated /etc/localtime
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:21 af kernel: BIOS Vendor: Intel Corp.=20
Jan 10 23:24:21 af postfix: postfix-script: successfully you probably wan=
t to copy that update to /var/spool/postfix/etc/localtime.
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:22 af kernel: BIOS Version: 4A4LL0X0.86A.0031.P14=20
Jan 10 23:24:22 af postfix: postfix-script: WARNING: The file /var/spool/=
postfix/etc/resolv.conf was originally created as a copy of
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:22 af kernel: BIOS Release: 04/16/99=20
Jan 10 23:24:22 af postfix: postfix-script: /etc/resolv.conf. They are no=
w different. If you have updated /etc/resolv.conf
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:22 af kernel: Board Vendor: Intel Corporation.=20
Jan 10 23:24:22 af postfix: postfix-script: successfully you probably wan=
t to copy that update to /var/spool/postfix/etc/resolv.conf.
Jan 10 23:24:00 af bastille-firewall: Setting up IP spoofing protection..=
=2E done.=20
Jan 10 23:24:22 af kernel: Board Name: AL440LX.=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:22 af kernel: Board Version: AA681537-304.=20
Jan 10 23:24:22 af rc: Starting postfix succeeded
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:23 af kernel: IA-32 Microcode Update Driver: v1.08 <tigran@v=
eritas.com>=20
Jan 10 23:24:23 af junkbuster: Starting junkbuster:
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:24 af kernel: apm: BIOS version 1.2 Flags 0x03 (Driver versi=
on 1.14)=20
Jan 10 23:24:24 af PAM_pwdb[660]: (su) session opened for user nobody by =
(uid=3D0)
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:24 af kernel: Starting kswapd v1.8=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:24 af junkbuster:=20
Jan 10 23:24:25 af kernel: pty: 256 Unix98 ptys configured=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:25 af rc: Starting junkbuster failed
Jan 10 23:24:25 af kernel: RAMDISK driver initialized: 16 RAM disks of 40=
96K size 1024 blocksize=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:25 af kernel: Uniform Multi-Platform E-IDE driver Revision: =
6.31=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:26 af wwwoffled[687]: Can't get IP address for host [Name Lo=
okup Non-Authoritive Answer Host not found].=20
Jan 10 23:24:26 af kernel: ide: Assuming 33MHz system bus speed for PIO m=
odes; override with idebus=3Dxx=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:26 af wwwoffled[687]: Can't get IP address for host [Name Lo=
okup Non-Authoritive Answer Host not found].=20
Jan 10 23:24:26 af kernel: PIIX4: IDE controller on PCI bus 00 dev 39=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:27 af kernel: PIIX4: chipset revision 1=20
Jan 10 23:24:27 af kernel: PIIX4: not 100%% native mode: will probe irqs =
later=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:27 af kernel:     ide0: BM-DMA at 0x1480-0x1487, BIOS settin=
gs: hda:pio, hdb:DMA=20
Jan 10 23:24:26 af wwwoffled[687]: WWWOFFLE Demon Version 2.5e started.=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:27 af kernel:     ide1: BM-DMA at 0x1488-0x148f, BIOS settin=
gs: hdc:DMA, hdd:pio=20
Jan 10 23:24:27 af wwwoffled: wwwoffled startup succeeded
Jan 10 23:24:27 af wwwoffled[695]: Detached from terminal and changed pid=
 to 695.=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:27 af kernel: PDC20262: IDE controller on PCI bus 00 dev 70=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:28 af kernel: PCI: Found IRQ 11 for device 00:0e.0=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:28 af kernel: PDC20262: chipset revision 1=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:28 af kernel: PDC20262: not 100%% native mode: will probe ir=
qs later=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:28 af kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary PCI=
 Mode Secondary PCI Mode.=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:29 af kernel:     ide2: BM-DMA at 0x1400-0x1407, BIOS settin=
gs: hde:DMA, hdf:pio=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:29 af kernel:     ide3: BM-DMA at 0x1408-0x140f, BIOS settin=
gs: hdg:pio, hdh:DMA=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:29 af kernel: hda: FUJITSU MPB3032ATU, ATA DISK drive=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:29 af kernel: hdb: IBM-DTTA-351010, ATA DISK drive=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:29 af kernel: hdc: 40X CD-ROM, ATAPI CDROM drive=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:30 af kernel: hde: WDC WD205BA, ATA DISK drive=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:30 af kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:30 af kernel: ide1 at 0x170-0x177,0x376 on irq 15=20
Jan 10 23:24:00 af bastille-firewall: Setting up masquerading rules...=20
Jan 10 23:24:30 af kernel: ide2 at 0x14a0-0x14a7,0x1496 on irq 11=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:30 af kernel: hda: 6335280 sectors (3244 MB), CHS=3D785/128/=
63, UDMA(33)=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:31 af kernel: hdb: 19807200 sectors (10141 MB) w/466KiB Cach=
e, CHS=3D1232/255/63, UDMA(33)=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:31 af kernel: hde: 40088160 sectors (20525 MB) w/2048KiB Cac=
he, CHS=3D39770/16/63, UDMA(66)=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:32 af kernel: Partition check:=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:32 af kernel:  hda: hda1 hda2 < hda5 > hda3=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:33 af kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:33 af kernel:  hde: hde1 hde2 hde3 hde4 < hde5 hde6 >=20
Jan 10 23:24:00 af bastille-firewall:  done.=20
Jan 10 23:24:33 af kernel: Serial driver version 5.02 (2000-08-09) with M=
ANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled=20
Jan 10 23:24:00 af bastille-firewall: Loading masquerading modules...=20
Jan 10 23:24:34 af kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A=20
Jan 10 23:24:00 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:34 af kernel: ttyS01 at 0x02f8 (irq =3D 3) is a 16550A=20
Jan 10 23:24:00 af bastille-firewall: insmod: ip_masq_ftp: no module by t=
hat name found=20
Jan 10 23:24:34 af kernel: Software Watchdog Timer: 0.05, timer margin: 6=
0 sec=20
Jan 10 23:24:00 af bastille-firewall: Error loading ip_masq_ftp module=20
Jan 10 23:24:34 af kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortm=
aker=20
Jan 10 23:24:00 af bastille-firewall: Error loading ip_masq_raudio module=
=20
Jan 10 23:24:34 af kernel:   http://www.scyld.com/network/ne2k-pci.html=20
Jan 10 23:24:00 af bastille-firewall: insmod: ip_masq_raudio: no module b=
y that name found=20
Jan 10 23:24:35 af kernel: PCI: Found IRQ 9 for device 00:10.0=20
Jan 10 23:24:00 af bastille-firewall: insmod: =20
Jan 10 23:24:35 af kernel: PCI: The same IRQ used for device 00:07.2=20
Jan 10 23:24:01 af bastille-firewall: Error loading ip_masq_vdolive modul=
e=20
Jan 10 23:24:35 af kernel: eth0: RealTek RTL-8029 found at 0x1460, IRQ 9,=
 00:20:18:2D:D7:CE.=20
Jan 10 23:24:01 af bastille-firewall:  done.=20
Jan 10 23:24:35 af kernel: PPP generic driver version 2.4.1=20
Jan 10 23:24:01 af bastille-firewall: Setting up general rules...WARNING:=
 no non-loopback local addresses; protection from INTERNAL_IFACES not ena=
bled!=20
Jan 10 23:24:35 af kernel: PPP Deflate Compression module registered=20
Jan 10 23:24:01 af bastille-firewall: ip_masq_vdolive: no module by that =
name found=20
Jan 10 23:24:35 af kernel: PPP BSD Compression module registered=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:36 af kernel: [drm] Initialized tdfx 1.0.0 20000928 on minor=
 63=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:36 af xfs: xfs startup succeeded
Jan 10 23:24:36 af kernel: usb.c: registered new driver hub=20
Jan 10 23:24:36 af xfs: Warning: The directory "/usr/share/fonts/default/=
TrueType" does not exist.=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:36 af kernel: PCI: Found IRQ 9 for device 00:07.2=20
Jan 10 23:24:37 af xfs:          Entry deleted from font path.=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:37 af kernel: PCI: The same IRQ used for device 00:10.0=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:37 af kernel: uhci.c: USB UHCI at I/O 0x1440, IRQ 9=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:38 af kernel: uhci.c: detected 2 ports=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:38 af kernel: usb.c: new USB bus registered, assigned bus nu=
mber 1=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:01 af last message repeated 3 times
Jan 10 23:24:41 af kernel: Product: USB UHCI-alt Root Hub=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:41 af kernel: SerialNumber: 1440=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:42 af kernel: hub.c: USB hub found=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:01 af last message repeated 2 times
Jan 10 23:24:42 af kernel: hub.c: 2 ports detected=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:01 af last message repeated 10 times
Jan 10 23:24:43 af kernel: usb.c: registered new driver usbscanner=20
Jan 10 23:24:43 af kernel: scanner.c: USB Scanner support registered.=20
Jan 10 23:24:43 af kernel: raid1 personality registered=20
Jan 10 23:24:01 af bastille-firewall:  done.=20
Jan 10 23:24:43 af kernel: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISK=
S=3D27=20
Jan 10 23:24:43 af kernel: md.c: sizeof(mdp_super_t) =3D 4096=20
Jan 10 23:24:43 af kernel: autodetecting RAID arrays=20
Jan 10 23:24:43 af kernel: (read) hda1's sb offset: 24128 [events: 000000=
61]=20
Jan 10 23:24:43 af kernel: (read) hda5's sb offset: 2769856 [events: 0000=
0062]=20
Jan 10 23:24:01 af bastille-firewall: Setting up outbound rules...=20
Jan 10 23:24:43 af kernel: (read) hdb3's sb offset: 24000 [events: 000000=
61]=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:43 af kernel: (read) hdb5's sb offset: 2771072 [events: 0000=
0062]=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:43 af kernel: (read) hdb7's sb offset: 3863488 [events: 0000=
0052]=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:44 af kernel: (read) hde2's sb offset: 3863552 [events: 0000=
0052]=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:44 af kernel: autorun ...=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:45 af kernel: considering hde2 ...=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:45 af kernel:   adding hde2 ...=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:46 af kernel:   adding hdb7 ...=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:46 af kernel: created md2=20
Jan 10 23:24:01 af bastille-firewall: ipchains: Protocol not available=20
Jan 10 23:24:46 af kernel: bind<hdb7,1>=20
Jan 10 23:24:01 af bastille-firewall:  done.=20
Jan 10 23:24:47 af kernel: bind<hde2,2>=20
Jan 10 23:24:01 af rc: Starting bastille-firewall succeeded=20
Jan 10 23:24:47 af kernel: running: <hde2><hdb7>=20
Jan 10 23:24:01 af sysctl: net.ipv4.ip_forward =3D 0=20
Jan 10 23:24:47 af kdm[791]: Cannot open server authorization file /usr/e=
tc/X11/xdm/authdir/A:0-0eH5Tu=20
Jan 10 23:24:47 af kernel: now!=20
Jan 10 23:24:01 af sysctl: net.ipv4.conf.all.rp_filter =3D 1=20
Jan 10 23:24:47 af kernel: hde2's event counter: 00000052=20
Jan 10 23:24:01 af sysctl: kernel.sysrq =3D 0=20
Jan 10 23:24:47 af kernel: hdb7's event counter: 00000052=20
Jan 10 23:24:01 af sysctl: error: 'net.ipv4.ip_always_defrag' is an unkno=
wn key=20
Jan 10 23:24:48 af kernel: md2: max total readahead window set to 124k=20
Jan 10 23:24:01 af network: Setting network parameters succeeded=20
Jan 10 23:24:48 af kernel: md2: 1 data-disks, max readahead per data-disk=
: 124k=20
Jan 10 23:24:01 af ifup: SIOCADDRT: Network is unreachable=20
Jan 10 23:24:48 af kernel: raid1: device hde2 operational as mirror 0=20
Jan 10 23:24:02 af network: Bringing up interface lo succeeded=20
Jan 10 23:24:48 af kernel: raid1: device hdb7 operational as mirror 1=20
Jan 10 23:24:02 af ifup: SIOCADDRT: Network is unreachable=20
Jan 10 23:24:49 af kernel: (checking disk 0)=20
Jan 10 23:24:02 af network: Bringing up interface eth0 succeeded=20
Jan 10 23:24:49 af kernel: (really checking disk 0)=20
Jan 10 23:24:02 af apmd[466]: Version 3.0final (APM BIOS 1.2, Linux drive=
r 1.14)=20
Jan 10 23:24:49 af kernel: (checking disk 1)=20
Jan 10 23:24:02 af apmd: apmd startup succeeded=20
Jan 10 23:24:49 af kernel: (really checking disk 1)=20
Jan 10 23:24:03 af apcupsd:  succeeded=20
Jan 10 23:24:50 af kernel: (checking disk 2)=20
Jan 10 23:24:04 af random: Initializing random number generator succeeded=
=20
Jan 10 23:24:50 af kernel: (checking disk 3)=20
Jan 10 23:24:50 af kernel: (checking disk 4)=20
Jan 10 23:24:50 af kernel: (checking disk 5)=20
Jan 10 23:24:50 af kernel: (checking disk 6)=20
Jan 10 23:24:50 af kernel: (checking disk 7)=20
Jan 10 23:24:50 af kernel: (checking disk 8)=20
Jan 10 23:24:50 af kernel: (checking disk 9)=20
Jan 10 23:24:51 af kernel: (checking disk 10)=20
Jan 10 23:24:51 af kernel: (checking disk 11)=20
Jan 10 23:24:51 af kernel: (checking disk 12)=20
Jan 10 23:24:51 af kernel: (checking disk 13)=20
Jan 10 23:24:51 af kernel: (checking disk 14)=20
Jan 10 23:24:51 af kernel: (checking disk 15)=20
Jan 10 23:24:51 af kernel: (checking disk 16)=20
Jan 10 23:24:52 af kernel: (checking disk 17)=20
Jan 10 23:24:52 af kernel: (checking disk 18)=20
Jan 10 23:24:52 af kernel: (checking disk 19)=20
Jan 10 23:24:52 af kernel: (checking disk 20)=20
Jan 10 23:24:52 af kernel: (checking disk 21)=20
Jan 10 23:24:52 af kernel: (checking disk 22)=20
Jan 10 23:24:52 af kernel: (checking disk 23)=20
Jan 10 23:24:52 af kernel: (checking disk 24)=20
Jan 10 23:24:52 af kernel: (checking disk 25)=20
Jan 10 23:24:52 af kernel: (checking disk 26)=20
Jan 10 23:24:52 af kernel: raid1: raid set md2 active with 2 out of 2 mir=
rors=20
Jan 10 23:24:52 af kernel: md: updating md2 RAID superblock on device=20
Jan 10 23:24:52 af kernel: hde2 [events: 00000053](write) hde2's sb offse=
t: 3863552=20
Jan 10 23:24:52 af kernel: hdb7 [events: 00000053](write) hdb7's sb offse=
t: 3863488=20
Jan 10 23:24:52 af kernel: .=20
Jan 10 23:24:52 af kernel: considering hdb5 ...=20
Jan 10 23:24:53 af kernel:   adding hdb5 ...=20
Jan 10 23:24:53 af kernel:   adding hda5 ...=20
Jan 10 23:24:53 af kernel: created md1=20
Jan 10 23:24:53 af kernel: bind<hda5,1>=20
Jan 10 23:24:53 af kernel: bind<hdb5,2>=20
Jan 10 23:24:53 af kernel: running: <hdb5><hda5>=20
Jan 10 23:24:53 af kernel: now!=20
Jan 10 23:24:53 af kernel: hdb5's event counter: 00000062=20
Jan 10 23:24:53 af kernel: hda5's event counter: 00000062=20
Jan 10 23:24:53 af kernel: md1: max total readahead window set to 124k=20
Jan 10 23:24:54 af kernel: md1: 1 data-disks, max readahead per data-disk=
: 124k=20
Jan 10 23:24:54 af kernel: raid1: device hdb5 operational as mirror 1=20
Jan 10 23:24:54 af kernel: raid1: device hda5 operational as mirror 0=20
Jan 10 23:24:54 af kernel: (checking disk 0)=20
Jan 10 23:24:54 af kernel: (really checking disk 0)=20
Jan 10 23:24:54 af kernel: (checking disk 1)=20
Jan 10 23:24:54 af kernel: (really checking disk 1)=20
Jan 10 23:24:54 af kernel: (checking disk 2)=20
Jan 10 23:24:54 af kernel: (checking disk 3)=20
Jan 10 23:24:54 af kernel: (checking disk 4)=20
Jan 10 23:24:54 af kernel: (checking disk 5)=20
Jan 10 23:24:54 af kernel: (checking disk 6)=20
Jan 10 23:24:54 af kernel: (checking disk 7)=20
Jan 10 23:24:54 af kernel: (checking disk 8)=20
Jan 10 23:24:54 af kernel: (checking disk 9)=20
Jan 10 23:24:54 af kernel: (checking disk 10)=20
Jan 10 23:24:55 af kernel: (checking disk 11)=20
Jan 10 23:24:55 af kernel: (checking disk 12)=20
Jan 10 23:24:55 af kernel: (checking disk 13)=20
Jan 10 23:24:55 af kernel: (checking disk 14)=20
Jan 10 23:24:55 af kernel: (checking disk 15)=20
Jan 10 23:24:55 af kernel: (checking disk 16)=20
Jan 10 23:24:55 af kernel: (checking disk 17)=20
Jan 10 23:24:55 af kernel: (checking disk 18)=20
Jan 10 23:24:55 af kernel: (checking disk 19)=20
Jan 10 23:24:55 af kernel: (checking disk 20)=20
Jan 10 23:24:56 af kernel: (checking disk 21)=20
Jan 10 23:24:56 af kernel: (checking disk 22)=20
Jan 10 23:24:57 af kernel: (checking disk 23)=20
Jan 10 23:24:57 af kernel: (checking disk 24)=20
Jan 10 23:24:57 af kernel: (checking disk 25)=20
Jan 10 23:24:57 af kernel: (checking disk 26)=20
Jan 10 23:24:58 af kernel: raid1: raid set md1 active with 2 out of 2 mir=
rors=20
Jan 10 23:24:58 af kernel: md: updating md1 RAID superblock on device=20
Jan 10 23:24:58 af kernel: hdb5 [events: 00000063](write) hdb5's sb offse=
t: 2771072=20
Jan 10 23:24:58 af kernel: hda5 [events: 00000063](write) hda5's sb offse=
t: 2769856=20
Jan 10 23:24:58 af kernel: .=20
Jan 10 23:24:58 af kernel: considering hdb3 ...=20
Jan 10 23:24:58 af kernel:   adding hdb3 ...=20
Jan 10 23:24:58 af kernel:   adding hda1 ...=20
Jan 10 23:24:58 af kernel: created md0=20
Jan 10 23:24:59 af kernel: bind<hda1,1>=20
Jan 10 23:24:59 af kernel: bind<hdb3,2>=20
Jan 10 23:24:59 af kernel: running: <hdb3><hda1>=20
Jan 10 23:24:59 af kernel: now!=20
Jan 10 23:24:59 af kernel: hdb3's event counter: 00000061=20
Jan 10 23:24:59 af kernel: hda1's event counter: 00000061=20
Jan 10 23:24:59 af kernel: md0: max total readahead window set to 124k=20
Jan 10 23:24:59 af kernel: md0: 1 data-disks, max readahead per data-disk=
: 124k=20
Jan 10 23:24:59 af kernel: raid1: device hdb3 operational as mirror 1=20
Jan 10 23:24:59 af kernel: raid1: device hda1 operational as mirror 0=20
Jan 10 23:24:59 af kernel: (checking disk 0)=20
Jan 10 23:25:00 af kernel: (really checking disk 0)=20
Jan 10 23:25:00 af kernel: (checking disk 1)=20
Jan 10 23:25:00 af kernel: (really checking disk 1)=20
Jan 10 23:25:00 af kernel: (checking disk 2)=20
Jan 10 23:25:01 af kernel: (checking disk 3)=20
Jan 10 23:25:01 af kernel: (checking disk 4)=20
Jan 10 23:25:01 af kernel: (checking disk 5)=20
Jan 10 23:25:02 af kernel: (checking disk 6)=20
Jan 10 23:25:02 af kernel: (checking disk 7)=20
Jan 10 23:25:03 af kernel: (checking disk 8)=20
Jan 10 23:25:03 af kernel: (checking disk 9)=20
Jan 10 23:25:03 af kernel: (checking disk 10)=20
Jan 10 23:25:03 af kernel: (checking disk 11)=20
Jan 10 23:25:03 af kernel: (checking disk 12)=20
Jan 10 23:25:04 af kernel: (checking disk 13)=20
Jan 10 23:25:04 af kernel: (checking disk 14)=20
Jan 10 23:25:04 af kernel: (checking disk 15)=20
Jan 10 23:25:04 af kernel: (checking disk 16)=20
Jan 10 23:25:04 af kernel: (checking disk 17)=20
Jan 10 23:25:04 af kernel: (checking disk 18)=20
Jan 10 23:25:04 af kernel: (checking disk 19)=20
Jan 10 23:25:04 af kernel: (checking disk 20)=20
Jan 10 23:25:04 af kernel: (checking disk 21)=20
Jan 10 23:25:05 af kernel: (checking disk 22)=20
Jan 10 23:25:05 af kernel: (checking disk 23)=20
Jan 10 23:25:05 af kernel: (checking disk 24)=20
Jan 10 23:25:06 af kernel: (checking disk 25)=20
Jan 10 23:25:06 af kernel: (checking disk 26)=20
Jan 10 23:25:06 af kernel: raid1: raid set md0 active with 2 out of 2 mir=
rors=20
Jan 10 23:25:07 af kernel: md: updating md0 RAID superblock on device=20
Jan 10 23:25:07 af kernel: hdb3 [events: 00000062](write) hdb3's sb offse=
t: 24000=20
Jan 10 23:25:07 af kernel: hda1 [events: 00000062](write) hda1's sb offse=
t: 24128=20
Jan 10 23:25:07 af kernel: .=20
Jan 10 23:25:07 af kernel: ... autorun DONE.=20
Jan 10 23:25:07 af kernel: NET4: Linux TCP/IP 1.0 for NET4.0=20
Jan 10 23:25:07 af kernel: IP Protocols: ICMP, UDP, TCP=20
Jan 10 23:25:07 af kernel: IP: routing cache hash table of 1024 buckets, =
8Kbytes=20
Jan 10 23:25:07 af kernel: TCP: Hash tables configured (established 8192 =
bind 8192)=20
Jan 10 23:25:07 af kernel: NET4: Unix domain sockets 1.0/SMP for Linux NE=
T4.0.=20
Jan 10 23:25:07 af kernel: VFS: Mounted root (ext2 filesystem) readonly.=20
Jan 10 23:25:08 af kernel: Freeing unused kernel memory: 196k freed=20
Jan 10 23:25:08 af kernel: Adding Swap: 136512k swap-space (priority -1)=20
Jan 10 23:25:08 af kernel: Adding Swap: 131504k swap-space (priority -2)=20
Jan 10 23:25:08 af kernel: Soundblaster audio driver Copyright (C) by Han=
nu Savolainen 1993-1996=20
Jan 10 23:25:08 af kernel: sb: Creative SB16 PnP detected=20
Jan 10 23:25:08 af kernel: sb: ISAPnP reports 'Creative SB16 PnP' at i/o =
0x220, irq 5, dma 1, 5=20
Jan 10 23:25:08 af kernel: SB 4.13 detected OK (220)=20
Jan 10 23:25:08 af kernel: <Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1=
,5=20
Jan 10 23:25:08 af kernel: <Sound Blaster 16> at 0x330 irq 5 dma 0,0=20
Jan 10 23:25:08 af kernel: sb: 1 Soundblaster PnP card(s) found.=20
Jan 10 23:25:08 af kernel: EXT2-fs warning: mounting unchecked fs, runnin=
g e2fsck is recommended=20
Jan 10 23:25:08 af kernel: Adding Swap: 99992k swap-space (priority -3)=20
Jan 10 23:25:43 af PAM_pwdb[803]: (kde) session opened for user Ops by (u=
id=3D0)
Jan 10 23:25:53 af modprobe: modprobe: Can't locate module sound-slot-1
Jan 10 23:25:53 af modprobe: modprobe: Can't locate module sound-service-=
1-0
Jan 10 23:25:53 af modprobe: modprobe: Can't locate module sound-slot-1
Jan 10 23:25:53 af modprobe: modprobe: Can't locate module sound-service-=
1-0
Jan 10 23:26:51 af apcupsd[480]: apcupsd apcupsd-3.8.0 startup succeeded
Jan 10 23:26:51 af apcupsd[950]: apcserver startup succeeded
Jan 10 23:27:20 af PAM_pwdb[951]: (su) session opened for user root by (u=
id=3D501)
Jan 10 23:28:05 af modprobe: modprobe: Can't locate module ppp0
Jan 10 23:28:05 af modprobe: modprobe: Can't locate module ppp0
Jan 10 23:28:05 af pppd[996]: pppd 2.4.0 started by root, uid 0
Jan 10 23:28:05 af pppd[996]: Using interface ppp0
Jan 10 23:28:05 af pppd[996]: Connect: ppp0 <--> /dev/ttyS0
Jan 10 23:28:12 af pppd[996]: local  IP address 151.33.177.80
Jan 10 23:28:12 af pppd[996]: remote IP address 151.5.145.158
Jan 10 23:28:12 af pppd[996]: primary   DNS address 193.70.152.25
Jan 10 23:28:12 af pppd[996]: secondary DNS address 193.70.192.25
Jan 11 00:09:14 af pppd[996]: Terminating on signal 15.
Jan 11 00:09:14 af pppd[996]: Connection terminated.
Jan 11 00:09:14 af pppd[996]: Connect time 41.2 minutes.
Jan 11 00:09:14 af pppd[996]: Sent 190408 bytes, received 1382769 bytes.
Jan 11 00:09:14 af pppd[996]: Exit.
Jan 11 07:00:29 af anacron[1240]: Updated timestamp for job `cron.daily' =
to 2001-01-11
Jan 11 14:27:41 af modprobe: modprobe: Can't locate module ppp0
Jan 11 14:27:41 af modprobe: modprobe: Can't locate module ppp0
Jan 11 14:27:41 af pppd[1779]: pppd 2.4.0 started by root, uid 0
Jan 11 14:27:41 af pppd[1779]: Using interface ppp0
Jan 11 14:27:42 af pppd[1779]: Connect: ppp0 <--> /dev/ttyS0
Jan 11 14:27:45 af pppd[1779]: local  IP address 151.33.182.148
Jan 11 14:27:45 af pppd[1779]: remote IP address 151.5.145.155
Jan 11 14:27:45 af pppd[1779]: primary   DNS address 193.70.152.25
Jan 11 14:27:45 af pppd[1779]: secondary DNS address 193.70.192.25
Jan 11 15:01:14 af PAM_pwdb[2037]: (su) session opened for user root by (=
uid=3D501)
Jan 11 16:16:57 af pppd[1779]: Hangup (SIGHUP)
Jan 11 16:16:57 af pppd[1779]: Modem hangup
Jan 11 16:16:57 af pppd[1779]: Connection terminated.
Jan 11 16:16:57 af pppd[1779]: Connect time 109.3 minutes.
Jan 11 16:16:57 af pppd[1779]: Sent 476068 bytes, received 5257009 bytes.
Jan 11 16:16:58 af modprobe: modprobe: Can't locate module ppp0
Jan 11 16:16:58 af last message repeated 3 times
Jan 11 16:16:58 af pppd[1779]: Exit.
Jan 11 17:12:54 af adduser[7069]: new group: name=3Dsandra, gid=3D503=20
Jan 11 17:12:54 af adduser[7069]: new user: name=3Dsandra, uid=3D503, gid=
=3D503, home=3D/home/sandra, shell=3D/bin/bash=20
Jan 11 17:46:11 af modprobe: modprobe: Can't locate module ppp0
Jan 11 17:46:12 af last message repeated 2 times
Jan 11 17:46:12 af pppd[7188]: pppd 2.4.0 started by root, uid 0
Jan 11 17:46:12 af pppd[7188]: Using interface ppp0
Jan 11 17:46:12 af pppd[7188]: Connect: ppp0 <--> /dev/ttyS0
Jan 11 17:46:21 af pppd[7188]: local  IP address 151.33.177.46
Jan 11 17:46:21 af pppd[7188]: remote IP address 151.5.145.158
Jan 11 17:46:21 af pppd[7188]: primary   DNS address 193.70.152.25
Jan 11 17:46:21 af pppd[7188]: secondary DNS address 193.70.192.25
Jan 11 18:27:36 af pppd[7188]: Hangup (SIGHUP)
Jan 11 18:27:36 af pppd[7188]: Modem hangup
Jan 11 18:27:36 af pppd[7188]: Connection terminated.
Jan 11 18:27:36 af pppd[7188]: Connect time 41.4 minutes.
Jan 11 18:27:36 af pppd[7188]: Sent 203502 bytes, received 3276017 bytes.
Jan 11 18:27:36 af modprobe: modprobe: Can't locate module ppp0
Jan 11 18:27:37 af last message repeated 2 times
Jan 11 18:27:37 af pppd[7188]: Exit.
Jan 11 18:28:12 af modprobe: modprobe: Can't locate module ppp0
Jan 11 18:28:12 af modprobe: modprobe: Can't locate module ppp0
Jan 11 18:28:12 af pppd[7412]: pppd 2.4.0 started by root, uid 0
Jan 11 18:28:12 af pppd[7412]: Using interface ppp0
Jan 11 18:28:12 af pppd[7412]: Connect: ppp0 <--> /dev/ttyS0
Jan 11 18:28:19 af pppd[7412]: local  IP address 151.33.177.46
Jan 11 18:28:19 af pppd[7412]: remote IP address 151.5.145.158
Jan 11 18:28:19 af pppd[7412]: primary   DNS address 193.70.152.25
Jan 11 18:28:19 af pppd[7412]: secondary DNS address 193.70.192.25
Jan 11 19:27:37 af kernel: hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA=
(33)=20
Jan 11 19:27:37 af kernel: Uniform CD-ROM driver Revision: 3.12=20
Jan 11 19:31:15 af pppd[7412]: Hangup (SIGHUP)
Jan 11 19:31:15 af pppd[7412]: Modem hangup
Jan 11 19:31:15 af pppd[7412]: Connection terminated.
Jan 11 19:31:15 af pppd[7412]: Connect time 63.1 minutes.
Jan 11 19:31:15 af pppd[7412]: Sent 648329 bytes, received 13540068 bytes=
=2E
Jan 11 19:31:16 af modprobe: modprobe: Can't locate module ppp0
Jan 11 19:31:17 af last message repeated 3 times
Jan 11 19:31:17 af pppd[7412]: Exit.
Jan 11 19:31:17 af modprobe: modprobe: Can't locate module ppp0
Jan 11 19:31:53 af modprobe: modprobe: Can't locate module ppp0
Jan 11 19:31:53 af last message repeated 2 times
Jan 11 19:31:53 af pppd[8531]: pppd 2.4.0 started by root, uid 0
Jan 11 19:31:53 af pppd[8531]: Using interface ppp0
Jan 11 19:31:53 af pppd[8531]: Connect: ppp0 <--> /dev/ttyS0
Jan 11 19:31:57 af pppd[8531]: local  IP address 151.33.177.46
Jan 11 19:31:57 af pppd[8531]: remote IP address 151.5.145.158
Jan 11 19:31:57 af pppd[8531]: primary   DNS address 193.70.152.25
Jan 11 19:31:57 af pppd[8531]: secondary DNS address 193.70.192.25
Jan 11 20:30:02 af pppd[8531]: Terminating on signal 15.
Jan 11 20:30:02 af pppd[8531]: Connection terminated.
Jan 11 20:30:02 af pppd[8531]: Connect time 58.2 minutes.
Jan 11 20:30:02 af pppd[8531]: Sent 434819 bytes, received 14117780 bytes=
=2E
Jan 11 20:30:03 af pppd[8531]: Exit.
Jan 11 23:00:14 af modprobe: modprobe: Can't locate module ppp0
Jan 11 23:00:15 af last message repeated 9 times
Jan 11 23:00:15 af pppd[10968]: pppd 2.4.0 started by root, uid 0
Jan 11 23:00:15 af pppd[10968]: Using interface ppp0
Jan 11 23:00:15 af pppd[10968]: Connect: ppp0 <--> /dev/ttyS0
Jan 11 23:00:19 af pppd[10968]: local  IP address 151.33.183.230
Jan 11 23:00:19 af pppd[10968]: remote IP address 151.5.145.155
Jan 11 23:00:19 af pppd[10968]: primary   DNS address 193.70.152.25
Jan 11 23:00:19 af pppd[10968]: secondary DNS address 193.70.192.25
Jan 11 23:23:49 af kernel: Adding Swap: 99992k swap-space (priority -4)=20
Jan 11 23:41:57 af sshd[11099]: Accepted password for ROOT from 192.168.1=
=2E10 port 904
Jan 11 23:42:03 af sshd[11099]: Could not reverse map address 192.168.1.1=
0.
Jan 11 23:42:03 af PAM_pwdb[11099]: (sshd) session opened for user root b=
y (uid=3D0)
Jan 11 23:43:27 af PAM_pwdb[803]: (kde) session closed for user Ops
Jan 11 23:43:32 af rebootonpanic: Enabling reboot on panic...
Jan 11 23:43:32 af rc: Starting rebootonpanic succeeded
Jan 11 23:43:33 af bastille-firewall:=20
Jan 11 23:43:33 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:33 af last message repeated 5 times
Jan 11 23:43:33 af bastille-firewall: Setting up IP spoofing protection..=
=2E done.
Jan 11 23:43:33 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:33 af last message repeated 24 times
Jan 11 23:43:33 af bastille-firewall: Setting up masquerading rules...
Jan 11 23:43:33 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:33 af last message repeated 4 times
Jan 11 23:43:33 af bastille-firewall:  done.
Jan 11 23:43:33 af bastille-firewall: Loading masquerading modules...
Jan 11 23:43:33 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:33 af last message repeated 2 times
Jan 11 23:43:35 af bastille-firewall: Error loading ip_masq_ftp module
Jan 11 23:43:35 af bastille-firewall: insmod: ip_masq_ftp: no module by t=
hat name found
Jan 11 23:43:35 af bastille-firewall: Error loading ip_masq_raudio module
Jan 11 23:43:35 af bastille-firewall: insmod: ip_masq_raudio: no module b=
y that name found
Jan 11 23:43:35 af bastille-firewall: insmod:=20
Jan 11 23:43:35 af bastille-firewall: Error loading ip_masq_vdolive modul=
e
Jan 11 23:43:35 af bastille-firewall:  done.
Jan 11 23:43:35 af bastille-firewall: ip_masq_vdolive: no module by that =
name found
Jan 11 23:43:35 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:35 af last message repeated 2 times
Jan 11 23:43:35 af bastille-firewall: Setting up general rules...
Jan 11 23:43:35 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:35 af last message repeated 42 times
Jan 11 23:43:35 af bastille-firewall:  done.
Jan 11 23:43:35 af bastille-firewall: Setting up outbound rules...
Jan 11 23:43:35 af bastille-firewall: ipchains: Protocol not available
Jan 11 23:43:35 af last message repeated 8 times
Jan 11 23:43:35 af bastille-firewall:  done.
Jan 11 23:43:35 af rc: Starting bastille-firewall succeeded
Jan 11 23:43:36 af snort: Initializing daemon mode
Jan 11 23:43:36 af kernel: device eth0 entered promiscuous mode=20
Jan 11 23:43:36 af snortd: snort startup succeeded
Jan 11 23:43:37 af kernel: device eth0 left promiscuous mode=20
Jan 11 23:43:37 af junkbuster: Already started:=20
Jan 11 23:43:37 af junkbuster: junkbuster (pid 662) is running...
Jan 11 23:43:37 af rc: Starting junkbuster succeeded
Jan 11 23:46:49 af PAM_pwdb[2037]: (su) session closed for user root
Jan 11 23:46:51 af PAM_pwdb[951]: (su) session closed for user root
Jan 11 23:47:37 af rc: Stopping keytable succeeded
Jan 11 23:47:37 af Font Server[768]: terminating=20
Jan 11 23:47:37 af xfs: xfs shutdown succeeded
Jan 11 23:47:37 af PAM_pwdb[11099]: (sshd) session closed for user root
Jan 11 23:47:37 af wwwoffled[695]: Exit signalled.=20
Jan 11 23:47:38 af wwwoffled[695]: Exiting.=20
Jan 11 23:47:39 af wwwoffled: wwwoffled shutdown succeeded
Jan 11 23:47:39 af sshd[571]: Received signal 15; terminating.
Jan 11 23:47:39 af sshd: sshd shutdown succeeded
Jan 11 23:47:39 af postfix: Shutting down postfix:=20
Jan 11 23:47:40 af postfix:=20
Jan 11 23:47:40 af rc: Stopping postfix succeeded
Jan 11 23:47:40 af crond: crond shutdown succeeded
Jan 11 23:47:40 af identd: identd shutdown succeeded
Jan 11 23:47:41 af dd: 1+0 records in
Jan 11 23:47:41 af dd: 1+0 records out
Jan 11 23:47:41 af random: Saving random seed succeeded
Jan 11 23:47:41 af apmd: apmd shutdown succeeded
Jan 11 23:47:42 af network: Shutting down interface eth0 succeeded
Jan 11 23:47:42 af sysctl: net.ipv4.ip_forward =3D 0
Jan 11 23:47:42 af network: Disabling IPv4 packet forwarding succeeded
Jan 11 23:47:42 af apcupsd[480]: apcupsd exiting, signal 15=20
Jan 11 23:47:43 af apcupsd[480]: apcupsd shutdown succeeded
Jan 11 23:47:43 af apcupsd: apcupsd shutdown succeeded
Jan 11 23:47:44 af kernel: Kernel logging (proc) stopped.
Jan 11 23:47:44 af kernel: Kernel log daemon terminating.
Jan 11 23:47:45 af syslog: klogd shutdown succeeded
Jan 11 23:47:45 af exiting on signal 15

--------------Boundary-00=_M2U0LWWUG9R0272IME5O--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
