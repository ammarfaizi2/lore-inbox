Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSAGNXe>; Mon, 7 Jan 2002 08:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSAGNWh>; Mon, 7 Jan 2002 08:22:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289197AbSAGNVz>; Mon, 7 Jan 2002 08:21:55 -0500
Subject: Re: "APIC error on CPUx" - what does this mean?
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Mon, 7 Jan 2002 13:33:00 +0000 (GMT)
Cc: cw@f00f.org (Chris Wedgwood), swsnyder@home.com,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <E37DB7922B4@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Jan 07, 2002 02:16:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NZtc-0001Cf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> whether IRQ7 happens directly when we send confirmation to 8259,
> or whether it happens due to some noise on IRQ line.
> 
> AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using 
> APIC.

Are you using an AMD northbridge and VIA southbridge together ?
