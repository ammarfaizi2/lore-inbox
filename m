Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDBCs4>; Sun, 1 Apr 2001 22:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDBCsq>; Sun, 1 Apr 2001 22:48:46 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:50194 "HELO
	mail12.speakeasy.net") by vger.kernel.org with SMTP
	id <S132606AbRDBCse>; Sun, 1 Apr 2001 22:48:34 -0400
Message-ID: <3AC7DA90.BA522CF2@megapathdsl.net>
Date: Sun, 01 Apr 2001 18:49:04 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
   Manfred Spraul <manfred@colorfullife.com>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401160430.28121K-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

<snip>

> /proc/pci data alone with every bug report is usually invaluable.  It
> gives you a really good idea of the general layout of the system, and
> you can often catch or become aware of related hardware characteristics
> which

I often see requests for the output of "lspci -vvxxx" when developers
are looking into problems with handling pci bus bridging and quirks
in specific hardware.  For example, this info has been requested of
me for debugging a problem handling my Neomagic 2160, at least one
bug in early Yenta code and so on.  Does /proc/pci get you all the
information that would be obtained with "lspci -vvxxx"?

> linux/REPORTINGS-BUGS was created to give users a hint that we need
> -more- information, and tells exactly what general information is useful
> to provide.  We do not need less information.

Agreed.

	Miles
