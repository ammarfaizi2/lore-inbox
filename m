Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269954AbSISF5S>; Thu, 19 Sep 2002 01:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269968AbSISF5S>; Thu, 19 Sep 2002 01:57:18 -0400
Received: from bs1.dnx.de ([213.252.143.130]:62617 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S269954AbSISF5R>;
	Thu, 19 Sep 2002 01:57:17 -0400
Date: Thu, 19 Sep 2002 08:02:18 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Christer Weinigel <christer@weinigel.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which processor/board for embedded NTP
Message-ID: <20020919060218.GD10773@pengutronix.de>
References: <1032354632.23252.14.camel@venus> <87r8frqech.fsf@zoo.weinigel.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87r8frqech.fsf@zoo.weinigel.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christer, 

On Wed, Sep 18, 2002 at 09:37:02PM +0200, Christer Weinigel wrote:
> On the newer "IA on a chip" geodes (SC1200, SC2200 and SC3200) there
> is also a high speed timer in the chipset that seems to be quite
> stable.

Did the realtime behaviour of the newer Geodes also change to the
better? Last time we tested them with RTAI there have been Buslocks
which prevented them from being usefull...

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
