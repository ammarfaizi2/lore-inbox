Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbRERTVZ>; Fri, 18 May 2001 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbRERTVP>; Fri, 18 May 2001 15:21:15 -0400
Received: from web11304.mail.yahoo.com ([216.136.131.207]:56841 "HELO
	web11304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261458AbRERTVL>; Fri, 18 May 2001 15:21:11 -0400
Message-ID: <20010518192110.22434.qmail@web11304.mail.yahoo.com>
Date: Fri, 18 May 2001 12:21:10 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: DMA support for toshiba IDE controllers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to clarify, this is a custom Toshiba chipset.  It
includes IDE, PCI controller, etc.  I believe the IDE
controller may be on the ISA bus as it does not show
up with lspci, etc. I'm not sure of the exact chip,
perhaps someone with a better knowledge of toshiab
products does.

Thanks,

Alex


> Does anyone know if there is any DMA support for the
> toshiba IDE controller's in many of their portable
> models such as the older porteges and librettos? 
The
> controllers support DMA, but not in linux.  I'm not
> sure what toshiba's policy is on documentation. 
They
> used to be pretty stingy, but I heard they have
> recently opened up of lot of their doc's, like the
> oboe IR controller for instance. 
> 
> Thanks,
> 
> Alex
> 

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
