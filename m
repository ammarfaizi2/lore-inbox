Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268743AbTCCTrg>; Mon, 3 Mar 2003 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268745AbTCCTrg>; Mon, 3 Mar 2003 14:47:36 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:64130 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268743AbTCCTre>; Mon, 3 Mar 2003 14:47:34 -0500
Date: Mon, 3 Mar 2003 20:57:50 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Edward King <edk@cendatsys.com>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Mikael Pettersson <mikpe@user.it.uu.se>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: re: Linux 2.4.21pre4-ac5 status report
Message-ID: <20030303195750.GI6946@louise.pinerecords.com>
References: <200303011252.h21CqBpl013357@harpo.it.uu.se> <1046523858.26074.7.camel@sun> <3E63B227.8030101@cendatsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E63B227.8030101@cendatsys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [edk@cendatsys.com]
> 
> >>Maybe that's changed in 2.4.21-pre-ac new IDE code, I don't know.
> >>
> >>Your cards don't share interrupts with anything else I hope?
> >>
> I tried  two pdc20268's which failed miserably
> 
> Used an Asus motherboard and an FIC motherboard, different cables, 
> different cards, different powersupply.Hard drives are 200GB western 
> digitals, one drive per channel.  
> 
> Tried an SIIG card with the SiI680 chipset -- same problem using is and 
> the pdc20268, but is more stable than a single pdc -- so now I have 4 
> drives on that card.
> 
> My kernel is 2.4.21-pre4-ac6 -- let me know if the pre5's solve the problem.

I'd be quite interested to know whether the FreeBSD IDE driver can handle
these setups properly.

-- 
Tomas Szepe <szepe@pinerecords.com>
