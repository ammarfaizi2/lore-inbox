Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKGTDG>; Tue, 7 Nov 2000 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKGTC4>; Tue, 7 Nov 2000 14:02:56 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:19213 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129045AbQKGTCx>; Tue, 7 Nov 2000 14:02:53 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDC57@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>
Cc: "'Russell King'" <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: USB init order dependencies. 
Date: Tue, 7 Nov 2000 11:02:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> randy.dunlap@intel.com said:
> >  Yes, your proposal is to init only "usbcore" from init/main.c. I
> > still don't see a need to do this in test10. It's fixed now AFAIK.
> 
> Not my proposal. The proposal to which Russell was objecting. 
> 
> My proposal was to just make the thing work without having to 
> care about the link order.
> 
> --
> dwmw2

OK, I stand corrected.  My bad.

Sounds like we basically all want the same thing.  :)

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
