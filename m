Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLNSL1>; Thu, 14 Dec 2000 13:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLNSLH>; Thu, 14 Dec 2000 13:11:07 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:17158 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129289AbQLNSLD>;
	Thu, 14 Dec 2000 13:11:03 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012141740.UAA02109@ms2.inr.ac.ru>
Subject: Re: linux ipv6 questions.  bugs?
To: pete@research.netsol.com (Pete Toscano)
Date: Thu, 14 Dec 2000 20:40:20 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001213162512.N1139@tesla.admin.cto.netsol.com> from "Pete Toscano" at Dec 13, 0 04:25:12 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Though... probably, you forgot to up loopback.
> 
> doesn't look it:

Funny, indeed.

I have no idea what does happen. I cannot reproduce this.
Please, describe your setup in more details.


> that may very well be, but shouldn't the neighbor solisitation packets
> from the linux box have the source mac address set to its mac address
> and the destination mac address set to 0:0:0:0:0:0 and not the other way
> around?

What NS do you talk about, if you even cannot ping even loopback? 8)8)8)

In such state you cannot expect of your system nothing but
generating some crap. BTW these funny mac addresses are exaclty
those one, which would be used on loopback, if it required ns. 8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
