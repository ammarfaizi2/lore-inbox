Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289360AbSA3QHS>; Wed, 30 Jan 2002 11:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289350AbSA3QHK>; Wed, 30 Jan 2002 11:07:10 -0500
Received: from bitmover.com ([192.132.92.2]:23973 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289344AbSA3QGn>;
	Wed, 30 Jan 2002 11:06:43 -0500
Date: Wed, 30 Jan 2002 08:06:42 -0800
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Rob Landley <landley@trommello.org>,
        Miles Lane <miles@megapathdsl.net>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130080642.E18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Rob Landley <landley@trommello.org>,
	Miles Lane <miles@megapathdsl.net>,
	Chris Ricker <kaboom@gatech.edu>,
	World Domination Now! <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130034746.K32317@havoc.gtf.org> <Pine.LNX.4.33.0201301350020.7674-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301350020.7674-100000@serv>; from zippel@linux-m68k.org on Wed, Jan 30, 2002 at 01:59:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:59:56PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 30 Jan 2002, Jeff Garzik wrote:
> 
> > Instead of doing this stuff half-assed, just convince Linus to use BK :)
> 
> I don't care what Linus uses, but Linus decision should not lock other
> developers into using the same tools, e.g. it should not become
> inconvenient to send simple patches. The basic communication tools should
> still be mail and patches. What we IMO need is a patch management system
> not a source management system.

BK can happily be used as a patch management system and it can, and has
for years, been able to accept and generate traditional patches.  Linus
could maintain the source in a BK tree and make it available as both
a BK tree and traditional patches.  It's a one line command to generate
a release patch and another one line command to generate the release
tarball.

By the way, you can send BK patches exactly the way that you send regular
patches, with the difference being that BK has an optional way of wrapping
them up in uuencode (or whatever) so that mailers don't stomp on them.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
