Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317095AbSEXGKo>; Fri, 24 May 2002 02:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSEXGKn>; Fri, 24 May 2002 02:10:43 -0400
Received: from bs1.dnx.de ([213.252.143.130]:10143 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S317095AbSEXGKl>;
	Fri, 24 May 2002 02:10:41 -0400
Date: Fri, 24 May 2002 07:39:20 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020524073920.T598@schwebel.de>
In-Reply-To: <Pine.LNX.4.33.0205231251430.2815-100000@penguin.transmeta.com> <3CED438B.6090906@evision-ventures.com> <20020523212239.EA736F5B@acolyte.hack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 11:22:39PM +0200, Christer Weinigel wrote:
> Please do *grin* I will probably have to write a driver for just such
> a card (a PC104 card though, but that's just a differenct connector),
> so I'd love to have such a driver.  And as long as the driver is
> self-contained and doesn't mess with other parts of the kernel I can't
> see why it shouldn't be included in Linus' tree.

COMEDI is the way to go for things like these. So if you want to make a
driver for your device you should subscribe the comedi mailing list first
and look if anybody has already done the work for you. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
