Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRB0Mp6>; Tue, 27 Feb 2001 07:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRB0Mps>; Tue, 27 Feb 2001 07:45:48 -0500
Received: from cc53440-a.catv1.md.home.com ([24.18.90.197]:17674 "EHLO
	dandelion.darkorb.net") by vger.kernel.org with ESMTP
	id <S129126AbRB0Mpj>; Tue, 27 Feb 2001 07:45:39 -0500
Date: Tue, 27 Feb 2001 07:45:36 -0500 (EST)
From: icognito <icognito@dandelion.darkorb.net>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: wavelan drivers
In-Reply-To: <Pine.LNX.4.10.10102271218410.26028-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.21.0102270745090.16205-100000@dandelion.darkorb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, i am playing with it now, seems to not like 2.4.2 too much, but i
am working at it. thanks again --gabe

On Tue, 27 Feb 2001, Matthew Kirkwood wrote:

> On Tue, 27 Feb 2001, icognito wrote:
> 
> > anyone know if there is an updated repository for the linux-wlan
> > project? i need drivers for the baystack 660 and none of the wlan n
> > modules in the distro in the site
> > (http://www.linux-wlan.com/linux-wlan/linux-wlan-0.3.4.tar.gz) compile
> > under 2.4.2... i can get the drivers to compile under 2.2.16 but nothing
> > beyond that, 2.4.2 drivers would be really cool if anyone has them thanks
> > in advance --gabe
> 
> Hi,
> 
> I have ported the driver to 2.4 with the in-kernel PCMCIA
> package.
> 
> It's a little bit broken (causes all sorts of warnings in
> dmesg, and will kill the machine if the card is removed)
> but it works once up.
> 
> You can get the patch (againt linux-2.4.0test13pre5, but
> applies to 2.4.2) at http://www.hairy.beasts.org/wlan-24.diff.gz
> 
> I initially intended to integrate it with the wireless LAN
> setup that's used for the other drivers, but haven't had
> time for that in several months.
> 
> Matthew.
> 
> 

