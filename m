Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266048AbRF1R1z>; Thu, 28 Jun 2001 13:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266050AbRF1R1p>; Thu, 28 Jun 2001 13:27:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39440 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266048AbRF1R1d>; Thu, 28 Jun 2001 13:27:33 -0400
Date: Thu, 28 Jun 2001 10:26:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <chuckw@altaserv.net>, Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>,
        David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <E15FfQy-0007IY-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106281024160.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, Alan Cox wrote:
>
> > As to the credit argument: put your copyright at the top of the source
> > file. The people who care and matter will see it. And do NOT hide the
> > copyright with reams of changelog information. Put that in a separate file
> > if you must.
>
> Managers at places like Cisco see boot messages and it gets into
> their brains. They certainly don't all read the source code.

I agree that they won't read the sources.

HOWEVER, it's also clearly unworkable to have everybody list their name,
This is what we have MAINTAINERS and CREDITS for.

Quote frankly, I doubt "managers" read the boot messages. They tend to ask
engineers who is responsible. I know I look in the MAINTAINERS file first,
then in the actual source code (some people don't want to be listed as
maintainers), and I don't think I've ever looked at a boot message on who
to worry about.

		Linus

