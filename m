Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129663AbRBXWaa>; Sat, 24 Feb 2001 17:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRBXWaV>; Sat, 24 Feb 2001 17:30:21 -0500
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:41469 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129663AbRBXWaF>;
	Sat, 24 Feb 2001 17:30:05 -0500
Message-ID: <3A98360C.C7258FA6@computing-services.oxford.ac.uk>
Date: Sat, 24 Feb 2001 22:30:36 +0000
From: A E Lawrence <adrian.lawrence@computing-services.oxford.ac.uk>
Organization: Not much
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: ian@wehrman.com, mhaque@haque.net, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <E14Wi2k-00009c-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I have seen similar problems on stock 2.4.2 a machine which has not run
> > 2.4.1.
> 
> What disk controllers ? We really need that sort of info in order to see the
> pattern in the odd reports of corruption we get

Sorry:-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000
	Capabilities: [c0] Power Management version 2

With dma enabled. If this is a known problem on this chipset, that may
be the explanation.

ael
-- 
A E Lawrence
