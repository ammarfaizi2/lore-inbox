Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271678AbRH0Jbw>; Mon, 27 Aug 2001 05:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271679AbRH0Jbm>; Mon, 27 Aug 2001 05:31:42 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:63664 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271678AbRH0Jbi>; Mon, 27 Aug 2001 05:31:38 -0400
Date: Mon, 27 Aug 2001 11:31:44 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@localhost.localdomain>
To: Thunder from the hill <schemins@netscape.net>
cc: <linux-kernel@vger.kernel.org>, <emu10k1-devel@opensource.creative.com>
Subject: Re: emu10k1 driver breakdown in 2.4.9?
In-Reply-To: <04F07016.7522E748.00A6DFE2@netscape.net>
Message-ID: <Pine.LNX.4.33.0108271130130.6839-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Thunder from the hill wrote:

Can you strace the player giving you trouble?
Do you see any kernel oops in /var/log/messages?

Rui Sousa

>
> ---------4f17ff67523f7284f17ff67523f728
> Content-Type: text/plain; charset=iso-8859-1
> Content-Transfer-Encoding: 8bit
> Content-Disposition: inline
>
> Hi,
>
> I am running Linux 2.4.9 compiled on gcc-2.95.2 with K6-II optimization and support for the emu10k1 cards, as I'm using a SB Live!. But whenever I play something that does not go straight to the soundcard (e.g. mp3), the program receives a SIGSEGV. No matter which program.
> It all worked fine on Linux-2.4.2, so it seems not the players fault.
>
> config.h appended.
>
> Thunder
>

