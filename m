Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbQKIS0b>; Thu, 9 Nov 2000 13:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbQKIS0V>; Thu, 9 Nov 2000 13:26:21 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:14857 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S130397AbQKIS0K>;
	Thu, 9 Nov 2000 13:26:10 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200011091801.SAA19861@gw.chygwyn.com>
Subject: Re: [patch] NE2000
To: kuznet@ms2.inr.ac.ru
Date: Thu, 9 Nov 2000 18:01:36 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), morton@nortelnetworks.com,
        andrewm@uow.edu.au, linux-kernel@vger.kernel.org
In-Reply-To: <200011091803.VAA05245@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Nov 09, 2000 09:03:51 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX8 6NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have to own up and say that it was me :-) you'll see that DECnet is the
only protocol to use these macros at the moment. I'm sure though that I
only copied what IPv4 was doing at the time, along with the hints I had
from yourself and Dave,

Steve.

> 
> Hello!
> 
> > Alexey!  Even someone understood all this already, look
> > to include/net/sock.h SOCK_SLEEP_{PRE,POST} macros :-)
> > 
> > I will compose a patch to fix all this.
> 
> O! But who was this wiseman? 8)
> 
> Alexey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
