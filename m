Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSA2BM6>; Mon, 28 Jan 2002 20:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSA2BMj>; Mon, 28 Jan 2002 20:12:39 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:16416 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S288274AbSA2BMb>; Mon, 28 Jan 2002 20:12:31 -0500
Date: Tue, 29 Jan 2002 12:39:00 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Doug Ledford <dledford@redhat.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i810 driver update.
In-Reply-To: <3C55D031.5040801@redhat.com>
Message-ID: <Pine.LNX.4.05.10201291229220.1513-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

> Marcelo,
> 
> This is the final, cooked version of the i810 driver.  It's been out long 
> enough for me to say with a good deal of certainty that it fixes quite a few 
> bugs in the existing driver and doesn't introduce any new bugs (that doesn't 
> mean it fixes all of the existing bugs though, record is still problematic 
> and full duplex isn't supported, but these aren't regressions since the 
> current driver is the same way).  This was diff'ed against the latest pre 
> patch.  Please apply this to your tree.  Thanks.
[...]

Are the fixes in this going to be applicable to 2.2 also (FWIW, 2.2's
i810_audio #defines ``DRIVER_VERSION "0.17"'')?

If so, is there any attempt to back-port this driver to 2.2?

I can test (at least compiling, booting and basic sound-playing), but not
back-port.

Thanks,
Neale.

