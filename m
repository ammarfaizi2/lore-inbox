Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130206AbRBZPcJ>; Mon, 26 Feb 2001 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130221AbRBZPcC>; Mon, 26 Feb 2001 10:32:02 -0500
Received: from vulcan.datanet.hu ([194.149.0.156]:2822 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S130206AbRBZPbt>;
	Mon, 26 Feb 2001 10:31:49 -0500
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: Datakart Geodzia KFT.
To: Felix von Leitner <leitner@convergence.de>
Date: Mon, 26 Feb 2001 16:31:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: USB and 2.4.2: "uhci: host system error, PCI problems?"
CC: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010223144004.A30274@convergence.de>
X-mailer: Pegasus Mail for Win32 (v3.01d)
Message-Id: <E14XPcd-00085C-00@aleph0.datakart.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felix von Leitner <leitner@convergence.de> wrote:

> Any ideas?  It's a VIA based Athlon board.  Worked fine with 2.4.0 and
> 2.4.1.  The only change was that I added rivafb, which finally adds
> Geforce support in 2.4.2.  /proc/interrupts does not show any interrupts
> assigned to rivafb, maybe there is a conflict?

Rivafb does not use interrupts at all.

Regards:
	Ferenc Bakonyi

