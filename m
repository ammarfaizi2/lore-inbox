Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLDKEG>; Mon, 4 Dec 2000 05:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLDKD4>; Mon, 4 Dec 2000 05:03:56 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129352AbQLDKDs>;
	Mon, 4 Dec 2000 05:03:48 -0500
Message-ID: <20001202233529.A7175@bug.ucw.cz>
Date: Sat, 2 Dec 2000 23:35:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
In-Reply-To: <200012020409.UAA04058@adam.yggdrasil.com> <90a065$5ai$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <90a065$5ai$1@penguin.transmeta.com>; from Linus Torvalds on Fri, Dec 01, 2000 at 09:09:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Anyway, I do have this machine working now, although not everything is
> to my liking.  Unlike older picture-books, for example, this one has a
> WinModem.  Ugh.  And the sound chip is supported, but only by the
  ~~~~~~~~~


> ALSA
> driver (the OSS version is too broken to be used). 

Great! Hopefully we can get some winmodem support under linux when
even you have winmodem. [I actually have two of them; one sneaked in
in toshiba laptop [supported as answering machine with open-source
software], second sneaked in philips velo [not supported but complete
docs available]].

What kind winmodem do you have? Anyways, now we need someone to write
v.34 stack :-(. There's v.32bis stack opensource for Irix [see links
from linmodems.org], if 14k4 connectivity is enough porting that might
be the way to go.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
