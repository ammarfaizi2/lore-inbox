Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEHqM>; Fri, 5 Jan 2001 02:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAEHqD>; Fri, 5 Jan 2001 02:46:03 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:19619 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129387AbRAEHpr>; Fri, 5 Jan 2001 02:45:47 -0500
Message-ID: <3A557D12.A5383794@uow.edu.au>
Date: Fri, 05 Jan 2001 18:51:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: I Lee Hetherington <ilh@sls.lcs.mit.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54E717.11A43B42@sls.lcs.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Lee Hetherington wrote:
> 
> Anybody get this working with 2.2.18 or 2.4.0-prerelease?  I can't seem
> to get the on-board 3c905c to work.  I've seen it without an interrupt
> assignment in /proc/interrupts.  With Red Hat's pump (DHCP), it sends
> packets out but doesn't seem to see the response.
> 
> I can provide more details.

Please do.  The boot-time messages which come out of the driver
would be interesting.  It would help if you add `debug=7' to
the 3c59x modprobe command line also.

Thanks.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
