Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSGEMnL>; Fri, 5 Jul 2002 08:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSGEMnK>; Fri, 5 Jul 2002 08:43:10 -0400
Received: from [207.156.7.21] ([207.156.7.21]:64674 "EHLO
	mail.hillsboroughcounty.org") by vger.kernel.org with ESMTP
	id <S317458AbSGEMnI> convert rfc822-to-8bit; Fri, 5 Jul 2002 08:43:08 -0400
Message-Id: <sd255cb2.030@GroupWise>
X-Mailer: Novell GroupWise Internet Agent 5.5.6.1
Date: Fri, 05 Jul 2002 08:45:26 -0400
From: "Brett Simpson" <Simpsonb@hillsboroughcounty.org>
To: <linux-kernel@vger.kernel.org>
Subject: Bttv errors with onboard video.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem where the bttv module will not work in combination with onboard ATI video.  The onboard ATI video card works fine but I get nothing from the encoding card. If I use a Cirrus logic PCI video card the bttv module works fine with xawtv. I see these error in my logs. Any ideas?

Jul  3 17:41:33 localhost kernel: bttv0: PLL: 28636363 => 35468950 ... ok
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765820
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765808
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765810
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765810
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765808
Jul  3 17:41:33 localhost kernel: bttv0: aiee: error loops
Jul  3 17:41:36 localhost kernel: bttv0: PLL: switching off
Jul  3 17:41:39 localhost kernel: bttv0: resetting chip

