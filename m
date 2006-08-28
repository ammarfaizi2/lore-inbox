Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWH1OS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWH1OS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWH1OS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:18:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31880 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750901AbWH1OSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:18:25 -0400
Subject: Re: Serial custom speed deprecated?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com>
References: <20060826181639.6545.qmail@science.horizon.com>
	 <Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Aug 2006 15:39:53 +0100
Message-Id: <1156775994.6271.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 08:17 -0400, ysgrifennodd linux-os (Dick Johnson):
> On Sat, 26 Aug 2006 linux@horizon.com wrote:
> 
> >> Or we could just add a standardised extra set of speed ioctls, but then
> >> we need to decide what occurs if I set the speed and then issue a
> >> termios call - does it override or not.
> >
> > Actually, we're not QUITE out of bits.  CBAUDEX | B0 is not taken.
> 
> B0 is not a bit (there are no bits in 0). It won't work.

Well that is how it is implemented and everyone else seems happy. If it
violates your personal laws of physics you'll just have to cope.

