Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130511AbRAWPVO>; Tue, 23 Jan 2001 10:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbRAWPVF>; Tue, 23 Jan 2001 10:21:05 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:48013
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S130511AbRAWPUw>; Tue, 23 Jan 2001 10:20:52 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCCC@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1-test10
Date: Tue, 23 Jan 2001 10:14:24 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]

> > Do the tulip driver updates address the increasingly common 
> NETDEV timeout
> > repots?
> 
> I don't see increasingly common timeout reports.. with which 
> hardware? 
> They are likely on the newer LinkSys 4.1 cards, and there are still
> problesm with PNIC.  Outside of that, other cards should be ok.

Hi Jeff,

Have you looked at the packet loss issue on the Znyx 4port cards?  Even
using the latest tulip driver, packet loss is still apparent with moderate
loads.

Cheers!
Jon

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
