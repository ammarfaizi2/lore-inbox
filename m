Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290344AbSBKUlW>; Mon, 11 Feb 2002 15:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290361AbSBKUlM>; Mon, 11 Feb 2002 15:41:12 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:54973 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S290344AbSBKUky>;
	Mon, 11 Feb 2002 15:40:54 -0500
Date: Mon, 11 Feb 2002 21:40:34 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jussi Laako <jussi.laako@kolumbus.fi>, linux-kernel@vger.kernel.org
Subject: Re: A7M266-D works?
In-Reply-To: <E16aMbQ-0007jI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0202112132040.16582-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2002, Alan Cox wrote:

> The current status on the board I'm using
> 
> -	The BIOS appears to misconfigure the PCI setup badly, so badly I've
> 	been sticking in PCI quirk fixups to make some drivers work

Could you give some examples of which drivers/cards you've seen problems
with. We've been thinking of getting a few of these boards but if there's
this much problems with the BIOS we might have to look at another board :(

I just read on Asus site that this board actually has been approved by
AMD.

"The A7M266-D is the first 760MPX chipset based motherboard to pass all of
AMD's validation requirements, ensuring superior reliability, performance
and quality."

It must have been running an unreleased BIOS at the time of the testing :)

> -	MP 1.4 locks solid MP 1.1 is ok - that may be a Linux bug. I have a
> 	patch to test there

Please test that patch and let us now.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


