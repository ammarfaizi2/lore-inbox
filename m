Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314452AbSDRUlA>; Thu, 18 Apr 2002 16:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314453AbSDRUk7>; Thu, 18 Apr 2002 16:40:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10763 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314452AbSDRUk7>; Thu, 18 Apr 2002 16:40:59 -0400
Date: Thu, 18 Apr 2002 13:39:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Lang <david.lang@digitalinsight.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: eNBD on loopback [was Re: [PATCH] 2.5.8 IDE 36]
In-Reply-To: <20020418203304.GB1327@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Apr 2002, Pavel Machek wrote:
> 
> > Btw, while I'm at it - who out there actually uses the new "enbd"
> > (Enhanced NBD)? I have this feeling that that would be the better choice,
> > since unlike plain nbd it should be deadlock-free on localhost (ie you
> > don't need a remote machine).
> 
> How does eNBD manage to do that? It was pretty hard last time I
> checked...

Don't ask me, I'm not a user, I have just seen the patch submissions, and
I just want to get real user feedback before I'd merge a new "extended
nbd".

So far I haven't heard anything from any actual users..

		Linus

