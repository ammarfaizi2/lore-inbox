Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSBODqP>; Thu, 14 Feb 2002 22:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSBODqF>; Thu, 14 Feb 2002 22:46:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63749 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286647AbSBODp6>; Thu, 14 Feb 2002 22:45:58 -0500
Date: Thu, 14 Feb 2002 19:43:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Pavel Machek <pavel@suse.cz>, "David S. Miller" <davem@redhat.com>,
        <dalecki@evision-ventures.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6C6E3C.8452F48B@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202141817300.14384-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Feb 2002, Jeff Garzik wrote:
> > 
> > But I'd like to see resulting epic100.tmpl ;-).
> 
> When you have to maintain more than 10 "cookie cutter" net drivers that
> are 80-90% the same, you start to want such extremes :)

It's not necessarily a bad idea to have a more capable preprocessor than
the C preprocessor. I've cursed preprocessor limitations before, and I
there was some discussion about using m4 several years ago (and I mean
_several_ years ago - if I were to guess I'd say 6-8 years ago..).

		Linus

