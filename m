Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbRHFLiT>; Mon, 6 Aug 2001 07:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267997AbRHFLiK>; Mon, 6 Aug 2001 07:38:10 -0400
Received: from [195.89.159.99] ([195.89.159.99]:10735 "EHLO thefinal.cern.ch")
	by vger.kernel.org with ESMTP id <S267986AbRHFLiB>;
	Mon, 6 Aug 2001 07:38:01 -0400
Date: Mon, 6 Aug 2001 12:39:11 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jussi Laako <jlaako@pp.htv.fi>
Cc: Russell King <rmk@arm.linux.org.uk>, Per Jessen <per.jessen@enidan.com>,
        linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
Message-ID: <20010806123910.A3771@thefinal.cern.ch>
In-Reply-To: <3B5D8A0A002D181A@mta2n.bluewin.ch> <20010801114105.A26615@flint.arm.linux.org.uk> <3B68557B.7816FE4B@pp.htv.fi> <20010801202409.A27667@flint.arm.linux.org.uk> <3B6B2B9F.1CFC220A@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6B2B9F.1CFC220A@pp.htv.fi>; from jlaako@pp.htv.fi on Sat, Aug 04, 2001 at 01:54:23AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> > Hmm, I'm not an x86 expert, so I'll have to leave you here.  What I do 
> > know is that yenta is for PCI-based PCMCIA controllers with CardBus 
> > support. i82365 is for ISA PCMCIA controllers only.
> 
> The machine has CardBus (at least CB-logo beside slots). It's Toshiba
> Satellite 300CDS.

Data point: I'm using the yenta_socket, pcnet_cs and 8390 modules on my
Toshiba 4070CDT with no problems, except that DHCP discovery doesn't
find an IP address for quite a while after I plug the card in.

enjoy,
-- Jamie
