Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWB0PUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWB0PUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWB0PUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:20:43 -0500
Received: from [129.59.116.43] ([129.59.116.43]:41371 "EHLO
	compsci.cas.vanderbilt.edu") by vger.kernel.org with ESMTP
	id S1751266AbWB0PUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:20:43 -0500
From: "S. Umar" <umar@compsci.cas.vanderbilt.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Date: Mon, 27 Feb 2006 09:20:42 -0600
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602270920.42474.umar@compsci.cas.vanderbilt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am just responding to your e-mail as well since I see the same problem.

Machine is Dell Precision 380, Dual Core, EM64T.

Codec is: snd_hda_codec

# lspci -vvv | grep ICH
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 (rev 01) (prog-if 00 [Normal decode])
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 (rev 01) (prog-if 00 [Normal decode])
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01) (prog-if 00 [UHCI])
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=AHCI (rev 01) (prog-if 01 [AHCI 1.0])
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
