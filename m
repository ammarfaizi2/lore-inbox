Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293165AbSBWR5i>; Sat, 23 Feb 2002 12:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293166AbSBWR53>; Sat, 23 Feb 2002 12:57:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25865 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293165AbSBWR5Z>; Sat, 23 Feb 2002 12:57:25 -0500
Date: Sat, 23 Feb 2002 09:56:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.10.10202221053320.32372-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0202230953290.14299-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Feb 2002, Andre Hedrick wrote:
> 
> Obvious you have a bug up the backside

Yes.

What really bugs me about this is that while normally you're hard to
communicate with, this time you have actively _lied_ about the patches on
IRC and in email about how they will cause IDE corruption etc due to
timing changes.

No such timing changes existed, and whenever you were asked about what was
actually actively _wrong_ with the patches, you didn't reply.

There's a difference between being difficult to work with and being 
actively dishonest, and you crossed that line.

		Linus

