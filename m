Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275062AbTHMPaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275201AbTHMPaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:30:14 -0400
Received: from angband.namesys.com ([212.16.7.85]:35986 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275062AbTHMPaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:30:11 -0400
Date: Wed, 13 Aug 2003 19:30:09 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030813153009.GA27209@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813171224.2a13b97f.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 13, 2003 at 05:12:24PM +0200, Stephan von Krawczynski wrote:

> Well, that's exactly the reason why I am awaiting some more days of
> up-and-running ext3. After how many days will you be convinced that a random
> memory corruption should have hit the ext3 system that bad, that it should have
> crashed?

Well, I'd prefer that you spend time to figure out at which exact
2.4.21-pre version the crashes in reiserfs started to appear. ;)

> I can add another week if you want me to, just tell me. The only thing I don't
> want is that any doubts are left after testing ...

It would be interesting to look at fsck results on the fs after some time of
testing.
Probably it would be easier for you to make it crash (if there are crash
possibility at all) if you enable JBD debugging.

Bye,
    Oleg
