Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311523AbSDUJXN>; Sun, 21 Apr 2002 05:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSDUJXM>; Sun, 21 Apr 2002 05:23:12 -0400
Received: from mail.scram.de ([195.226.127.117]:61131 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S311523AbSDUJXM>;
	Sun, 21 Apr 2002 05:23:12 -0400
Date: Sun, 21 Apr 2002 11:22:10 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Larry McVoy <lm@bitmover.com>
cc: Roman Zippel <zippel@linux-m68k.org>, Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <20020420171714.A31656@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0204211121010.18496-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

> Huh?  BK requires no more net access than you require when submitting
> a regular patch.  You need to be connected to move the bits.

Wrong. Many corporate firewalls allow email and http (both via proxy) and 
reject any other traffic. CVS and BK are both unusable in this 
environment.

--jochen

