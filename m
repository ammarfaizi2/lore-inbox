Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTGCLKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbTGCLKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:10:45 -0400
Received: from mx02.qsc.de ([213.148.130.14]:23244 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265069AbTGCLJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:09:10 -0400
Date: Thu, 3 Jul 2003 13:27:21 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: pcmcia problem [was: Re: 2.5.74-mm1]
Message-ID: <20030703112721.GC4266@gmx.de>
References: <20030703023714.55d13934.akpm@osdl.org> <20030703103703.GA4266@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20030703103703.GA4266@gmx.de>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.73-bk7-O1int0307021808  i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

correction, this happens on plain 2.5.74, too

On Thu, Jul 03, 2003 at 12:37:03PM +0200, Wiktor Wodecki wrote:
> On Thu, Jul 03, 2003 at 02:37:14AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.=
5.74-mm1/
>=20
> On my thinkpad T20 it boots up fine, however when I insert my ne2000
> pcmcia card it instantly freezes. No Ooops or log message at all.
> 2.5.73-mm1 did fine.
>=20
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
> (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
> (rev 03)
> 00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
> 00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
> 00:03.0 Communication controller: Lucent Microelectronics WinModem 56k
> (rev 01)
> 00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
> [CrystalClear SoundFusion Audio Accelerator] (rev 01)
> 00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
> 01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev
> 11)
>=20
>=20
> --=20
> Regards,
>=20
> Wiktor Wodecki

> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=3Dy
> CONFIG_MMU=3Dy
> CONFIG_UID16=3Dy
> CONFIG_GENERIC_ISA_DMA=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
>=20
> #
> # General setup
> #
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D14
> # CONFIG_EMBEDDED is not set
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=3Dy
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=3Dy
>=20
> #
> # Processor type and features
> #
> CONFIG_X86_PC=3Dy
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> CONFIG_MPENTIUMIII=3Dy
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> # CONFIG_HUGETLB_PAGE is not set
> # CONFIG_SMP is not set
> CONFIG_PREEMPT=3Dy
> CONFIG_X86_UP_APIC=3Dy
> CONFIG_X86_UP_IOAPIC=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCE_NONFATAL=3Dy
> # CONFIG_X86_MCE_P4THERMAL is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=3Dy
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_EDD=3Dy
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=3Dy
> CONFIG_HAVE_DEC_LOCK=3Dy
>=20
> #
> # Power management options (ACPI, APM)
> #
> CONFIG_PM=3Dy
> CONFIG_SOFTWARE_SUSPEND=3Dy
>=20
> #
> # ACPI Support
> #
> CONFIG_ACPI=3Dy
> # CONFIG_ACPI_HT_ONLY is not set
> CONFIG_ACPI_BOOT=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_SLEEP_PROC_FS=3Dy
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_THERMAL=3Dy
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_BUS=3Dy
> CONFIG_ACPI_INTERPRETER=3Dy
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_PCI=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> # CONFIG_APM is not set
>=20
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> # CONFIG_CPU_FREQ_PROC_INTF is not set
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> # CONFIG_CPU_FREQ_24_API is not set
> CONFIG_CPU_FREQ_TABLE=3Dy
>=20
> #
> # CPUFreq processor drivers
> #
> CONFIG_X86_ACPI_CPUFREQ=3Dy
> # CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> CONFIG_X86_SPEEDSTEP_ICH=3Dy
> CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
> CONFIG_X86_SPEEDSTEP_LIB=3Dy
> # CONFIG_X86_P4_CLOCKMOD is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
>=20
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> # CONFIG_PCI_LEGACY_PROC is not set
> CONFIG_PCI_NAMES=3Dy
> CONFIG_ISA=3Dy
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> CONFIG_HOTPLUG=3Dy
>=20
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=3Dy
> CONFIG_YENTA=3Dy
> CONFIG_CARDBUS=3Dy
> CONFIG_I82092=3Dy
> # CONFIG_I82365 is not set
> # CONFIG_TCIC is not set
> CONFIG_PCMCIA_PROBE=3Dy
>=20
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
>=20
> #
> # Executable file formats
> #
> CONFIG_KCORE_ELF=3Dy
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_AOUT=3Dm
> CONFIG_BINFMT_MISC=3Dy
>=20
> #
> # Generic Driver Options
> #
> # CONFIG_FW_LOADER is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
>=20
> #
> # Plug and Play support
> #
> CONFIG_PNP=3Dy
> CONFIG_PNP_NAMES=3Dy
> # CONFIG_PNP_DEBUG is not set
>=20
> #
> # Protocols
> #
> CONFIG_ISAPNP=3Dy
> CONFIG_PNPBIOS=3Dy
>=20
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=3Dm
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_BLK_DEV_INITRD is not set
> # CONFIG_LBD is not set
>=20
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=3Dy
>=20
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=3Dy
>=20
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=3Dy
> CONFIG_IDEDISK_MULTI_MODE=3Dy
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECS=3Dm
> CONFIG_BLK_DEV_IDECD=3Dm
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=3Dy
>=20
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_IDEPNP is not set
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_BLK_DEV_GENERIC=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> # CONFIG_BLK_DEV_IDE_TCQ is not set
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=3Dy
> CONFIG_IDEDMA_ONLYDISK=3Dy
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA=3Dy
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=3Dy
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=3Dy
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=3Dy
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI=3Dm
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_CHR_DEV_ST=3Dm
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=3Dm
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_CHR_DEV_SG=3Dm
>=20
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_MULTI_LUN=3Dy
> CONFIG_SCSI_REPORT_LUNS=3Dy
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
>=20
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_FERAL_ISP is not set
>=20
> #
> # PCMCIA SCSI adapter support
> #
> # CONFIG_PCMCIA_AHA152X is not set
> # CONFIG_PCMCIA_FDOMAIN is not set
> # CONFIG_PCMCIA_NINJA_SCSI is not set
> # CONFIG_PCMCIA_QLOGIC is not set
>=20
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
>=20
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
>=20
> #
> # Networking support
> #
> CONFIG_NET=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_NETLINK_DEV=3Dm
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_UNIX=3Dy
> # CONFIG_NET_KEY is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> CONFIG_INET_ECN=3Dy
> CONFIG_SYN_COOKIES=3Dy
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=3Dy
> CONFIG_IP_NF_FTP=3Dy
> CONFIG_IP_NF_IRC=3Dy
> # CONFIG_IP_NF_TFTP is not set
> # CONFIG_IP_NF_AMANDA is not set
> CONFIG_IP_NF_QUEUE=3Dm
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_MATCH_LIMIT=3Dm
> CONFIG_IP_NF_MATCH_MAC=3Dy
> CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
> CONFIG_IP_NF_MATCH_MARK=3Dy
> CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
> # CONFIG_IP_NF_MATCH_TOS is not set
> CONFIG_IP_NF_MATCH_RECENT=3Dy
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_DSCP is not set
> # CONFIG_IP_NF_MATCH_AH_ESP is not set
> # CONFIG_IP_NF_MATCH_LENGTH is not set
> # CONFIG_IP_NF_MATCH_TTL is not set
> # CONFIG_IP_NF_MATCH_TCPMSS is not set
> # CONFIG_IP_NF_MATCH_HELPER is not set
> CONFIG_IP_NF_MATCH_STATE=3Dy
> CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
> CONFIG_IP_NF_MATCH_UNCLEAN=3Dy
> # CONFIG_IP_NF_MATCH_OWNER is not set
> CONFIG_IP_NF_FILTER=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dy
> CONFIG_IP_NF_TARGET_MIRROR=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> # CONFIG_IP_NF_NAT_LOCAL is not set
> CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_IP_NF_NAT_IRC=3Dm
> CONFIG_IP_NF_NAT_FTP=3Dm
> CONFIG_IP_NF_MANGLE=3Dy
> CONFIG_IP_NF_TARGET_TOS=3Dy
> CONFIG_IP_NF_TARGET_ECN=3Dy
> CONFIG_IP_NF_TARGET_DSCP=3Dm
> CONFIG_IP_NF_TARGET_MARK=3Dy
> CONFIG_IP_NF_TARGET_LOG=3Dy
> CONFIG_IP_NF_TARGET_ULOG=3Dm
> CONFIG_IP_NF_TARGET_TCPMSS=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> # CONFIG_IP_NF_ARP_MANGLE is not set
> # CONFIG_IPV6 is not set
> # CONFIG_XFRM_USER is not set
>=20
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=3Dy
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_LLC is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>=20
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=3Dy
> CONFIG_NET_SCH_CBQ=3Dy
> CONFIG_NET_SCH_HTB=3Dy
> CONFIG_NET_SCH_CSZ=3Dy
> CONFIG_NET_SCH_PRIO=3Dy
> CONFIG_NET_SCH_RED=3Dy
> CONFIG_NET_SCH_SFQ=3Dy
> CONFIG_NET_SCH_TEQL=3Dy
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> # CONFIG_NET_SCH_INGRESS is not set
> CONFIG_NET_QOS=3Dy
> CONFIG_NET_ESTIMATOR=3Dy
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_TCINDEX=3Dy
> CONFIG_NET_CLS_ROUTE4=3Dy
> CONFIG_NET_CLS_ROUTE=3Dy
> CONFIG_NET_CLS_FW=3Dy
> CONFIG_NET_CLS_U32=3Dy
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> CONFIG_NET_CLS_POLICE=3Dy
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NETDEVICES=3Dy
>=20
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> # CONFIG_NET_SB1000 is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> # CONFIG_NET_ETHERNET is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
>=20
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PPP=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPPOE=3Dm
> CONFIG_SLIP=3Dy
> CONFIG_SLIP_COMPRESSED=3Dy
> CONFIG_SLIP_SMART=3Dy
> CONFIG_SLIP_MODE_SLIP6=3Dy
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Token Ring devices (depends on LLC=3Dy)
> #
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>=20
> #
> # PCMCIA network device support
> #
> CONFIG_NET_PCMCIA=3Dy
> # CONFIG_PCMCIA_3C589 is not set
> # CONFIG_PCMCIA_3C574 is not set
> # CONFIG_PCMCIA_FMVJ18X is not set
> CONFIG_PCMCIA_PCNET=3Dm
> # CONFIG_PCMCIA_NMCLAN is not set
> # CONFIG_PCMCIA_SMC91C92 is not set
> # CONFIG_PCMCIA_XIRC2PS is not set
> # CONFIG_PCMCIA_AXNET is not set
>=20
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>=20
> #
> # IrDA (infrared) support
> #
> CONFIG_IRDA=3Dy
>=20
> #
> # IrDA protocols
> #
> CONFIG_IRLAN=3Dm
> CONFIG_IRNET=3Dm
> CONFIG_IRCOMM=3Dy
> # CONFIG_IRDA_ULTRA is not set
>=20
> #
> # IrDA options
> #
> # CONFIG_IRDA_CACHE_LAST_LSAP is not set
> # CONFIG_IRDA_FAST_RR is not set
> # CONFIG_IRDA_DEBUG is not set
>=20
> #
> # Infrared-port device drivers
> #
>=20
> #
> # SIR device drivers
> #
> CONFIG_IRTTY_SIR=3Dy
>=20
> #
> # Dongle support
> #
> # CONFIG_DONGLE is not set
>=20
> #
> # Old SIR device drivers
> #
> # CONFIG_IRTTY_OLD is not set
> CONFIG_IRPORT_SIR=3Dy
>=20
> #
> # Old Serial dongle support
> #
> # CONFIG_DONGLE_OLD is not set
>=20
> #
> # FIR device drivers
> #
> # CONFIG_USB_IRDA is not set
> # CONFIG_NSC_FIR is not set
> # CONFIG_WINBOND_FIR is not set
> # CONFIG_TOSHIBA_OLD is not set
> # CONFIG_TOSHIBA_FIR is not set
> # CONFIG_SMC_IRCC_OLD is not set
> # CONFIG_SMC_IRCC_FIR is not set
> # CONFIG_ALI_FIR is not set
> # CONFIG_VLSI_FIR is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN_BOOL is not set
>=20
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=3Dy
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_SERIAL_NONSTANDARD is not set
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> # CONFIG_SERIAL_8250_CS is not set
> # CONFIG_SERIAL_8250_ACPI is not set
> # CONFIG_SERIAL_8250_EXTENDED is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_UNIX98_PTY_COUNT=3D256
>=20
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>=20
> #
> # I2C Hardware Sensors Mainboard support
> #
>=20
> #
> # I2C Hardware Sensors Chip support
> #
> # CONFIG_I2C_SENSOR is not set
>=20
> #
> # Mice
> #
> CONFIG_BUSMOUSE=3Dy
> # CONFIG_QIC02_TAPE is not set
>=20
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=3Dy
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> # CONFIG_AGP is not set
> # CONFIG_DRM is not set
>=20
> #
> # PCMCIA character devices
> #
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
>=20
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>=20
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>=20
> #
> # File systems
> #
> CONFIG_EXT2_FS=3Dy
> # CONFIG_EXT2_FS_XATTR is not set
> CONFIG_EXT3_FS=3Dy
> # CONFIG_EXT3_FS_XATTR is not set
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> CONFIG_AUTOFS4_FS=3Dy
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_ZISOFS_FS=3Dm
> CONFIG_UDF_FS=3Dm
>=20
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> CONFIG_NTFS_FS=3Dm
> # CONFIG_NTFS_DEBUG is not set
> # CONFIG_NTFS_RW is not set
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> # CONFIG_DEVFS_FS is not set
> CONFIG_DEVPTS_FS=3Dy
> # CONFIG_DEVPTS_FS_XATTR is not set
> CONFIG_TMPFS=3Dy
> CONFIG_RAMFS=3Dy
>=20
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
>=20
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=3Dm
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V4=3Dy
> CONFIG_NFS_DIRECTIO=3Dy
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V3=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_TCP=3Dy
> CONFIG_LOCKD=3Dm
> CONFIG_LOCKD_V4=3Dy
> CONFIG_EXPORTFS=3Dm
> CONFIG_SUNRPC=3Dm
> CONFIG_SUNRPC_GSS=3Dm
> CONFIG_SMB_FS=3Dm
> CONFIG_SMB_NLS_DEFAULT=3Dy
> CONFIG_SMB_NLS_REMOTE=3D"cp437"
> CONFIG_CIFS=3Dm
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> # CONFIG_AFS_FS is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_SMB_NLS=3Dy
> CONFIG_NLS=3Dy
>=20
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT=3D"iso8859-15"
> CONFIG_NLS_CODEPAGE_437=3Dy
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=3Dy
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ISO8859_1=3Dy
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> CONFIG_NLS_ISO8859_15=3Dy
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> CONFIG_NLS_UTF8=3Dy
>=20
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> CONFIG_VIDEO_SELECT=3Dy
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=3Dy
>=20
> #
> # Sound
> #
> CONFIG_SOUND=3Dy
>=20
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=3Dy
> CONFIG_SND_SEQUENCER=3Dy
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dy
> CONFIG_SND_PCM_OSS=3Dy
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_RTCTIMER=3Dy
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
>=20
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>=20
> #
> # ISA devices
> #
> # CONFIG_SND_AD1816A is not set
> # CONFIG_SND_AD1848 is not set
> # CONFIG_SND_CS4231 is not set
> # CONFIG_SND_CS4232 is not set
> # CONFIG_SND_CS4236 is not set
> # CONFIG_SND_ES968 is not set
> # CONFIG_SND_ES1688 is not set
> # CONFIG_SND_ES18XX is not set
> # CONFIG_SND_GUSCLASSIC is not set
> # CONFIG_SND_GUSEXTREME is not set
> # CONFIG_SND_GUSMAX is not set
> # CONFIG_SND_INTERWAVE is not set
> # CONFIG_SND_INTERWAVE_STB is not set
> # CONFIG_SND_OPTI92X_AD1848 is not set
> # CONFIG_SND_OPTI92X_CS4231 is not set
> # CONFIG_SND_OPTI93X is not set
> # CONFIG_SND_SB8 is not set
> # CONFIG_SND_SB16 is not set
> # CONFIG_SND_SBAWE is not set
> # CONFIG_SND_WAVEFRONT is not set
> # CONFIG_SND_ALS100 is not set
> # CONFIG_SND_AZT2320 is not set
> # CONFIG_SND_CMI8330 is not set
> # CONFIG_SND_DT019X is not set
> # CONFIG_SND_OPL3SA2 is not set
> # CONFIG_SND_SGALAXY is not set
> # CONFIG_SND_SSCAPE is not set
>=20
> #
> # PCI devices
> #
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_AZT3328 is not set
> CONFIG_SND_CS46XX=3Dy
> # CONFIG_SND_CS46XX_NEW_DSP is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_YMFPCI is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VX222 is not set
>=20
> #
> # ALSA USB devices
> #
> # CONFIG_SND_USB_AUDIO is not set
>=20
> #
> # PCMCIA devices
> #
> # CONFIG_SND_VXPOCKET is not set
> # CONFIG_SND_VXP440 is not set
>=20
> #
> # Open Sound System
> #
> # CONFIG_SOUND_PRIME is not set
>=20
> #
> # USB support
> #
> CONFIG_USB=3Dy
> # CONFIG_USB_DEBUG is not set
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=3Dy
> CONFIG_USB_BANDWIDTH=3Dy
> CONFIG_USB_DYNAMIC_MINORS=3Dy
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=3Dm
> # CONFIG_USB_OHCI_HCD is not set
> CONFIG_USB_UHCI_HCD=3Dy
>=20
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_MIDI is not set
> CONFIG_USB_ACM=3Dm
> CONFIG_USB_PRINTER=3Dm
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> CONFIG_USB_STORAGE_HP8200e=3Dy
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
>=20
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=3Dm
> CONFIG_USB_HIDINPUT=3Dy
> CONFIG_HID_FF=3Dy
> # CONFIG_HID_PID is not set
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_THRUSTMASTER_FF is not set
> CONFIG_USB_HIDDEV=3Dy
>=20
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_XPAD is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_SCANNER is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
>=20
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
>=20
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
>=20
> #
> # USB Network adaptors
> #
> # CONFIG_USB_AX8817X is not set
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
>=20
> #
> # USB port drivers
> #
>=20
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
>=20
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_BRLVGER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_GADGET is not set
>=20
> #
> # Bluetooth support
> #
> # CONFIG_BT is not set
>=20
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
>=20
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=3Dy
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_SPINLINE is not set
> # CONFIG_KALLSYMS is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_KGDB is not set
> CONFIG_DEBUG_INFO=3Dy
> # CONFIG_FRAME_POINTER is not set
> CONFIG_X86_EXTRA_IRQS=3Dy
> CONFIG_X86_FIND_SMP_CONFIG=3Dy
> CONFIG_X86_MPPARSE=3Dy
> # CONFIG_SLEEPOMETER is not set
>=20
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
>=20
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
>=20
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> CONFIG_ZLIB_INFLATE=3Dm
> CONFIG_ZLIB_DEFLATE=3Dm
> CONFIG_X86_BIOS_REBOOT=3Dy




--=20
Regards,

Wiktor Wodecki

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/BBMZ6SNaNRgsl4MRAjD7AKCHN9A/DmM+hIo5BT2L4bLYiGIYbACg0il/
o8ML1CDNyfEM/WSyW9EgRMg=
=PJAj
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
