Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136281AbRAZRQx>; Fri, 26 Jan 2001 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135186AbRAZRQn>; Fri, 26 Jan 2001 12:16:43 -0500
Received: from betty.magenta-netlogic.com ([193.37.229.181]:4358 "EHLO
	betty.magenta-netlogic.com") by vger.kernel.org with ESMTP
	id <S131707AbRAZRQ2>; Fri, 26 Jan 2001 12:16:28 -0500
Message-ID: <3A71B14D.267771A@magenta-netlogic.com>
Date: Fri, 26 Jan 2001 17:18:05 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta netLogic
X-Mailer: Mozilla 4.74 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: "Randal, Phil" <prandal@herefordshire.gov.uk>,
        "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <AFE36742FF57D411862500508BDE8DD055F6@mail.herefordshire.gov.uk> <20010126173744.A5164@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> 
> So you also turn of PMTU and just set the MTU to 200 bytes because broken
> firewalls may drop ICMP ?

That doesn't affect huge numbers of websites.

In the UK two of the largest ISPs - BT Internet and Freeserve - have
ECN-blocking
firewalls.  So does theregister.co.uk for that matter.  If I enable ECN
I lose
the ability to send emails to a huge percentage of the people on the
mailing lists
that run on my machine.

These ISPs will *not* change simply because 1% of Linux users complain
at them.  They
have been contacted about this and they know of the problem.  I doubt
they care.

Firewalls dropping ICMP does not make my internet connection practically
unusable.  Firewalls
dropping ECN does.

Tony

-- 

The only secure computer is one that's unplugged, locked in a safe,
and buried 20 feet under the ground in a secret location... and i'm
not even too sure about that one"--Dennis Huges, FBI.

tmh@magenta-netlogic.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
