Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSKRTEY>; Mon, 18 Nov 2002 14:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSKRTEY>; Mon, 18 Nov 2002 14:04:24 -0500
Received: from guru.webcon.net ([66.11.168.140]:36766 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S264730AbSKRTEX>;
	Mon, 18 Nov 2002 14:04:23 -0500
Date: Mon, 18 Nov 2002 14:11:16 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tco/rng support for Intel chipsets other than the i810?
In-Reply-To: <3DD9311A.3080006@pobox.com>
Message-ID: <Pine.LNX.4.44.0211181410000.16963-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jeff Garzik wrote:

> WRT RNG, more than just i810 supports RNG, yes.  There are several 
> chipset ids in i810_rng.c which are for later versions after i810.
> 
> So, the driver is perhaps misnamed at this point :) but it's not a huge 
> deal, so I haven't renamed it to i8xx_rng.c.  :)

Do you think I can just add an entry into the rng_pci_tbl[] for my 845PE
(8086, 2560) and have it work?

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------

