Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130465AbQLHO2B>; Fri, 8 Dec 2000 09:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQLHO1m>; Fri, 8 Dec 2000 09:27:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130465AbQLHO1k>; Fri, 8 Dec 2000 09:27:40 -0500
Subject: Re: 2.2.18pre21 oops reading /proc/apm
To: neale@lowendale.com.au (Neale Banks)
Date: Fri, 8 Dec 2000 13:57:20 +0000 (GMT)
Cc: sfr@linuxcare.com (Stephen Rothwell), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10012081420090.15256-300000@marina.lowendale.com.au> from "Neale Banks" at Dec 08, 2000 02:34:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144O1a-0003vF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I compiled the Debian distribution of 2.2.18pre21 source on and for a
> AcerNote-950, with APM enabled.
> 
> All is fine except that I can reliably "oops" it simply by trying to read
> from /proc/apm (e.g. cat /proc/apm).
> 
> oops output and ksymoops-2.3.4 output is attached.
> 
> Is there anything else I can contribute?

The latitude and longtitude of the bios writers current position, and
a ballistic missile.

Please boot 2.2.18pre24 (not pre25) on the machine and send me its DMI strings
printed at boot time. I'll add it to the 'stupid morons who cant program and
wouldnt know QA if it hit them on the head with a mallet' list

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
