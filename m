Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSGEEQq>; Fri, 5 Jul 2002 00:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGEEQp>; Fri, 5 Jul 2002 00:16:45 -0400
Received: from dialinpool.tiscali.de ([62.246.30.48]:64175 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S315277AbSGEEQo>; Fri, 5 Jul 2002 00:16:44 -0400
Date: Fri, 5 Jul 2002 06:18:41 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing BK architectures?
Message-ID: <20020705061841.C27989@dea.linux-mips.net>
References: <20020701184353.Q10782@work.bitmover.com> <Pine.LNX.4.44.0207041934490.1718-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207041934490.1718-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Thu, Jul 04, 2002 at 07:35:59PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 07:35:59PM -0700, James Simmons wrote:

> > Anyway, kudos to the HP guys aside, are there other architectures for
> > which someone wants a Linux port of BK?  I know we need to release a
> > zseries version, that's in the works (noone is donating a zseries and
> > I'm pretty sure we couldn't afford the power bill anyway, but I have
> > an account on their public server), but what about other archs?  Are
> > we missing any you care about?
> 
> I noticed a BK mips tree but it doesn't seem to active. Who is in charge
> of it? I really like to push some changes for MIPS into Linus tree.

Me but there isn't much sense in starting to use that bk tree before
MIPS has caught up with Linus, after all we're still at 2.5.2 ...

Pumping 2.5.2 to oss as I'm writing this,

  Ralf
