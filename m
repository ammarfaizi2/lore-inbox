Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbQKKHsZ>; Sat, 11 Nov 2000 02:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130010AbQKKHsP>; Sat, 11 Nov 2000 02:48:15 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27660 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129948AbQKKHsI>;
	Sat, 11 Nov 2000 02:48:08 -0500
Message-ID: <3A0CF991.CC1A3498@mandrakesoft.com>
Date: Sat, 11 Nov 2000 02:47:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Browning <danb@cyclonehq.dnsalias.net>
CC: willy tarreau <wtarreau@yahoo.fr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, const-g@xpert.com,
        danb@cyclonecomputers.com
Subject: Re: Intel's ANS Driver -vs- Bonding [was Re: Linux 2.2.18pre21]
In-Reply-To: <Pine.LNX.4.21.0011102032010.1963-100000@cyclonehq.dnsalias.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Browning wrote:
> 
> I think it is great that there is continued valuable developement on the
> bonding driver.  Have you guys taken a look at the source code for Intel's
> new ANS driver?  For any Intel network card, it will do 8-way Fast
> EtherChannel.  Supposedly, it also supports failover (though even
> "bonding" driver docs used to say that was impossible because the linux
> networking subsystem didn't handle card failures gracefully enough).
> 
> You can check it out at:
> 
> http://support.intel.com/support/network/adapter/pro100/100Linux.htm
> 
> Maybe some of the code will help in the "bonding" driver development.  I
> much prefer bonding over Intel's ANS, because bonding is GPL and works
> with any net card.  Etc. etc.

Alas, the license has the BSD documentation requirement, and thus is
incompatible with the GPL...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
