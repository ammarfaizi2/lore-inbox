Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRKHWlv>; Thu, 8 Nov 2001 17:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRKHWln>; Thu, 8 Nov 2001 17:41:43 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:45585 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S278690AbRKHWla>;
	Thu, 8 Nov 2001 17:41:30 -0500
Date: Thu, 8 Nov 2001 23:39:54 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
Message-ID: <20011108233954.D11523@unternet.org>
In-Reply-To: <8A11A922758@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8A11A922758@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Nov 08, 2001 at 11:34:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 11:34:38PM +0000, Petr Vandrovec wrote:
> If you see something different from your box, or from your VMs, tell me. 
> But adding some SCSI adapter is beyond PCI slots of my box. I also
> assume that you are using released VMware version, build 1455.

Yeah, using VMware build 1455 on ABit BP-6 with 2 * Celeron 466@466, 768 MB RAM
(dirt cheap nowadays so why not...), 2 * Maxtor 40GB IDE on BX controller, HPT
controller not in use, Matrox G400. I've seen the rtc: blah errors, stressed
the box to its limits with VM's with Linux/WinXP, and every now and then...

it just freezes... (only when using a Linus kernel, and only when using VMware)

I'll try 2.4.15pre, maybe it helps...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
