Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbTCGLL7>; Fri, 7 Mar 2003 06:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbTCGLL7>; Fri, 7 Mar 2003 06:11:59 -0500
Received: from poup.poupinou.org ([195.101.94.96]:2611 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S261520AbTCGLL6>;
	Fri, 7 Mar 2003 06:11:58 -0500
Date: Fri, 7 Mar 2003 12:22:25 +0100
To: CaT <cat@zip.com.au>
Cc: Dominik Brodowski <linux@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - cpu freq not turned on
Message-ID: <20030307112225.GA3923@poup.poupinou.org>
References: <20030306152616.GB432@zip.com.au> <20030306233228.GK1016@brodo.de> <20030307001724.GB588@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307001724.GB588@zip.com.au>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 11:17:24AM +1100, CaT wrote:
> Didn't apply the patch cos I don't see that in the lspci output:
> 
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
> 00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
> 

PIIX4EM southbridges are still in reverse-engeenering process.

Im also wondering why Intel still make this old stuff under NDA?

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
