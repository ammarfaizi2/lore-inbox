Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbQKPU0j>; Thu, 16 Nov 2000 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131397AbQKPU02>; Thu, 16 Nov 2000 15:26:28 -0500
Received: from mail.aslab.com ([205.219.89.194]:29204 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S131393AbQKPU0M>;
	Thu, 16 Nov 2000 15:26:12 -0500
Date: Thu, 16 Nov 2000 13:04:41 -0800 (PST)
From: "John D. Kim" <johnkim@aslab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: APM oops with Dell 5000e laptop
In-Reply-To: <E13wTbc-0008BC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.04.10011161254110.2078-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Alan Cox wrote:
> > The kernel works around/ignores/disables other broken hardware or broken
> > features of otherwise working hardware with black lists.  There will be
> > many *many* of these laptops sold.

> And I hope many many of these people demand BIOS upgrades or send them back.

Well, there will be a great number of these laptops sold, not just through
dell, but other brands that buy from compal.  But most of them will be
running Windows, and Windows seem to work fine with it.  So these
companies aren't going to see too many requests unless anyone who's even
considering buying a new laptop complain about this.  Compal provides no
communication channel for the consumers, so we have to go through the big
companies like dell.  When I e-mailed dell's tech support I got a response
from a guy who had *no* idea what linux is.

> > Is there a way to uniquely identify the affected BIOSes at boot time and

> Im looking at one with some pointers from Dell. It won't be in 2.2.18 so its
> quite likely a fixed BIOS will be out first anyway.

Wherever the fix comes from, I sure hope it comes soon, because it's
getting harder and harder to find cpus for the original 5000 series.  And
this new model's been sitting on my desk for couple of weeks now
collecting dust.

> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

John Kim

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
