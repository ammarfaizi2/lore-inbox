Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289078AbSAGCRl>; Sun, 6 Jan 2002 21:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289082AbSAGCRc>; Sun, 6 Jan 2002 21:17:32 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:60063
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289078AbSAGCRQ>; Sun, 6 Jan 2002 21:17:16 -0500
Date: Sun, 6 Jan 2002 21:02:33 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.arm.linux.org.uk
Subject: Missing entries in Configuure.help)
Message-ID: <20020106210233.A30319@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following symbols (mostly ARM port stuff) are missing enntries in
Configure.help.  Please contribute help entries if you can.

ARM:

6xx_GENERIC
ARCH_ADIFCC
ARCH_AUTCPU12
ARCH_CAMELOT
ARCH_CLPS711X
ARCH_CLPS7500
ARCH_CO285
ARCH_FOOTBRIDGE
ARCH_IOP310
ARCH_SA1100
ARCH_SHARK
CPU_ARM922_CPU_IDLE
CPU_ARM922_D_CACHE_ON
CPU_ARM922_I_CACHE_ON
CPU_ARM922_WRITETHROUGH
DEBUG_LL_SER3
DEBUG_WAITQ
H3600_SLEEVE
IOP310_AAU
IOP310_DMA
IOP310_MU
IOP310_PMON
SA1100_H3100
SA1100_H3800
SA1100_PT_SYSTEM3
SA1100_SHANNON
SA1100_USB
SA1100_USB_CHAR
SA1100_USB_NETLINK

Non-ARM:

USB_EHCI_HCD
USB_SERIAL_IPAQ
USB_SERIAL_KLSI
USB_STV680
USB_VICAM

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Government should be weak, amateurish and ridiculous. At present, it
fulfills only a third of the role.	-- Edward Abbey
