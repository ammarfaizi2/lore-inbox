Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbRFPSSF>; Sat, 16 Jun 2001 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbRFPSRz>; Sat, 16 Jun 2001 14:17:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20749 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264641AbRFPSRj>; Sat, 16 Jun 2001 14:17:39 -0400
Date: Sat, 16 Jun 2001 11:16:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Eric Smith <eric@brouhaha.com>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com, mj@ucw.cz
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <3B2B9DA3.3E310BF7@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0106161115320.9713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Jun 2001, Jeff Garzik wrote:
> 
> I am pretty lucky on Alpha, we already trust the kernel PCI code
> implicitly by unconditionally defining pcibios_assign_all_busses to one.
> :)

Well, the _real_ advantage on the alpha side is that there are only a
handful of systems, and those systems tend to be designed by an even
smaller number of companies.

That, in turn, makes it so easy to trust the kernel to have enough
knowledge.

		Linus

