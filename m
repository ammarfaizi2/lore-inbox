Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbRGFQIE>; Fri, 6 Jul 2001 12:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266747AbRGFQHy>; Fri, 6 Jul 2001 12:07:54 -0400
Received: from host002.Messe.Stuttgart.seicom.NET ([195.254.65.2]:42758 "EHLO
	snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S266746AbRGFQHj>; Fri, 6 Jul 2001 12:07:39 -0400
Date: Fri, 6 Jul 2001 08:09:37 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Current list of the missing-in-action
Message-ID: <20010706080937.A22601@thyrsus.com>
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

This is after a resync with 2.4.7-pre3:

CONFIG_AU1000_UART
CONFIG_ETRAX_ETHERNET_LPSLAVE
CONFIG_ETRAX_ETHERNET_LPSLAVE_HAS_LEDS
CONFIG_ETRAX_NETWORK_LED_ON_WHEN_ACTIVITY
CONFIG_ETRAX_NETWORK_LED_ON_WHEN_LINK
CONFIG_ETRAX_POWERBUTTON_BIT
CONFIG_ETRAX_SHUTDOWN_BIT
CONFIG_ETRAX_SOFT_SHUTDOWN
CONFIG_EVB_PCI1
CONFIG_FORWARD_KEYBOARD
CONFIG_GDB_CONSOLE
CONFIG_IT8172_REVC
CONFIG_IT8172_SCR0
CONFIG_IT8172_SCR1
CONFIG_SOUND_CMPCI_FM
CONFIG_SOUND_CMPCI_FMIO
CONFIG_SOUND_CMPCI_LINE_BASS
CONFIG_SOUND_CMPCI_LINE_REAR
CONFIG_SOUND_CMPCI_MIDI
CONFIG_SOUND_CMPCI_MPUIO
CONFIG_SOUND_CMPCI_SPDIFINVERSE
CONFIG_SYSCLK_100
CONFIG_SYSCLK_75
CONFIG_SYSCLK_83
CONFIG_TULIP_MMIO

I managed to write several of the entries for stuff associated with SOUND_CMPCI
myself.

Would the responsible maintainers please send me help entries for these?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Alcohol still kills more people every year than all `illegal' drugs put
together, and Prohibition only made it worse.  Oppose the War On Some Drugs!
