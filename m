Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbTAQRkf>; Fri, 17 Jan 2003 12:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTAQRkf>; Fri, 17 Jan 2003 12:40:35 -0500
Received: from havoc.daloft.com ([64.213.145.173]:43407 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267620AbTAQRke>;
	Fri, 17 Jan 2003 12:40:34 -0500
Date: Fri, 17 Jan 2003 12:49:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Cc: alan@redhat.com, akpm@digeo.com
Subject: cs89x0 in 2.5 (was Re: eepro100 - 802.1q - mtu size)
Message-ID: <20030117174928.GA8304@gtf.org>
References: <20030117145357.GA1139@paradigm.rfc822.org> <20030117160840.GR12676@stingr.net> <20030117162818.GA1074@gtf.org> <20030117172719.GA31343@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117172719.GA31343@codemonkey.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 05:27:19PM +0000, Dave Jones wrote:
> On Fri, Jan 17, 2003 at 11:28:18AM -0500, Jeff Garzik wrote:
> 
>  > The reason why the patch was not accepted is that it changes one magic
>  > number to another magic number, and without chipset docs, I had no idea
>  > what either magic number really meant.
> 
> Whilst on the subject of magic numbers in net drivers, did we ever get
> to the bottom of 2.4's ChangeSet 1.587.9.20 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.48/split-dj1/net-cs89x0-media-corrections.diff


IIRC it came from -ac tree without explanation, and I think akpm said it
broke stuff.  Since it has an alive maintainer (akpm), I would rather
let Alan and Andrew fight it out :)  Whatever they decide is fine with
me for 2.5.

	Jeff



