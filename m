Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSGHOEI>; Mon, 8 Jul 2002 10:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSGHOEH>; Mon, 8 Jul 2002 10:04:07 -0400
Received: from [207.156.7.21] ([207.156.7.21]:20660 "EHLO
	mail.hillsboroughcounty.org") by vger.kernel.org with ESMTP
	id <S316906AbSGHOEG> convert rfc822-to-8bit; Mon, 8 Jul 2002 10:04:06 -0400
Message-Id: <sd29642e.098@GroupWise>
X-Mailer: Novell GroupWise Internet Agent 5.5.6.1
Date: Mon, 08 Jul 2002 10:06:35 -0400
From: "Brett Simpson" <Simpsonb@hillsboroughcounty.org>
To: <mroos@linux.ee>, <linux-kernel@vger.kernel.org>
Subject: Re: Bttv errors with onboard video.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> VIA 686a, AMD Duron, 2.4.18,
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)

I read a post relating to something similar with the VIA chipset. I suppose the "bttv0: irq:
SCERR risc_count=1764e020" errors isn't the problem for why mine isn't working but just another normal error. Any idea on how to put the bttv module into a debug mode?

Brett

