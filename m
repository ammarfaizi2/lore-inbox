Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284204AbRLPDBt>; Sat, 15 Dec 2001 22:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284211AbRLPDBj>; Sat, 15 Dec 2001 22:01:39 -0500
Received: from fe090.worldonline.dk ([212.54.64.152]:8459 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S284210AbRLPDBd>; Sat, 15 Dec 2001 22:01:33 -0500
Date: Sun, 16 Dec 2001 04:00:31 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Daniel T. Chen" <crimsun@email.unc.edu>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_SOUND_DMAP: Confusing Configure.help entry.
In-Reply-To: <Pine.A41.4.21L1.0112152149430.11590-100000@login3.isis.unc.edu>
Message-ID: <Pine.LNX.4.33.0112160358590.4516-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Daniel T. Chen wrote:

> I'm assuming you have more than 16 MB of RAM, in which case it's safe to
> say Y here if you have an ISA soundcard.
> 
> The final line should probably be clarified to read: "Say Y if you have
> 16MB or more RAM and an ISA soundcard but N if you have a PCI sound
> card."
> 
Or

"Say Y unless you have less than 16MB of RAM or a PCI sound card."

That would also remove the contradiction.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

