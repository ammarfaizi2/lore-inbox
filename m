Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbRBAQP2>; Thu, 1 Feb 2001 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130851AbRBAQPS>; Thu, 1 Feb 2001 11:15:18 -0500
Received: from h57s242a129n47.user.nortelnetworks.com ([47.129.242.57]:12721
	"EHLO zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S129659AbRBAQPF>; Thu, 1 Feb 2001 11:15:05 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCEE@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'David S. Miller'" <davem@redhat.com>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: RE: [UPDATE] Fresh zerocopy patch on kernel.org
Date: Thu, 1 Feb 2001 11:06:30 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Malcolm Beattie writes:
>  > Alexey has mailed me suggesting the problem may be that netfilter
>  > is turned on.
> 
> Oh yes, netfilter being enabled will cause some performance
> degradation, that is for sure.

Do you think that netfilter being enabled would also cause a decrease in
routing throughput (ie: causing packet loss)?

Cheers!
Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
