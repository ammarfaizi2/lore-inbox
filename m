Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132986AbRADOkI>; Thu, 4 Jan 2001 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135199AbRADOkA>; Thu, 4 Jan 2001 09:40:00 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26894 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132986AbRADOjb>; Thu, 4 Jan 2001 09:39:31 -0500
Subject: Re: So, what about kwhich on RH6.2?
To: ak@suse.de (Andi Kleen)
Date: Thu, 4 Jan 2001 14:41:17 +0000 (GMT)
Cc: andrewm@uow.edu.au (Andrew Morton), zaitcev@metabyte.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010104091241.B18973@gruyere.muc.suse.de> from "Andi Kleen" at Jan 04, 2001 09:12:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EBZw-0005oG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jan 04, 2001 at 07:13:58PM +1100, Andrew Morton wrote:
> > Silly question:
> > 
> > can't we just hardwire `kgcc' into the build system and be done
> > with all this kwhich stuff?  It's just a symlink....
> 
> And break compilation on all non RedHat 7, non connectiva systems ? 
> Would you volunteer to handle the support load on l-k that would cause?

Hardcoding kgcc is definitely not an option. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
