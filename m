Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135897AbRDTMyA>; Fri, 20 Apr 2001 08:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135904AbRDTMxv>; Fri, 20 Apr 2001 08:53:51 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:65295 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135897AbRDTMxl>;
	Fri, 20 Apr 2001 08:53:41 -0400
Date: Fri, 20 Apr 2001 08:54:29 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Orphaned symbols in the Configure.help file
Message-ID: <20010420085429.A4820@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following symbols have entries in the Configure.help file but are 
not presently used by CML1.  Would the people who own these please tell
me which ones are genuinely dead so I can remove them?

m68k port:

CONFIG_A2232
CONFIG_PMAC

s390 port:

CONFIG_ARCH_S390
CONFIG_DASD_CKD
CONFIG_DASD_FAST_IO
CONFIG_IPLABLE
CONFIG_IPL_RDR
CONFIG_IPL_RDR_VM
CONFIG_S390_PARTITION

iA64 port:

CONFIG_IA64_AZUSA_HACKS
CONFIG_IA64_SOFTSDV_HACKS
CONFIG_ITANIUM_PTCG
CONFIG_NET_PROFILE

ARM port:

CONFIG_KEYBOARD_L7200
CONFIG_KEYBOARD_L7200_DEMO
CONFIG_KEYBOARD_L7200_NORM
CONFIG_SERIAL_L7200
CONFIG_SERIAL_L7200_CONSOLE
CONFIG_SERIAL_SA1100
CONFIG_SERIAL_SA1100_CONSOLE

Networking:

CONFIG_AX25_DAMA_MASTER
CONFIG_IP6_NF_MATCH_MAC
CONFIG_SKB_LARGE
CONFIG_SPX

General:

CONFIG_HOST_FOOTBRIDGE
CONFIG_IEEE1394_AIC5800
CONFIG_NCPFS_MOUNT_SUBDIR
CONFIG_NCPFS_NDS_DOMAINS
CONFIG_NFSD_TCP
CONFIG_NLS_ISO8859_10
CONFIG_TEXT_SECTIONS
CONFIG_USB_WMFORCE
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To make inexpensive guns impossible to get is to say that you're
putting a money test on getting a gun.  It's racism in its worst form.
        -- Roy Innis, president of the Congress of Racial Equality (CORE), 1988
