Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRCVKr7>; Thu, 22 Mar 2001 05:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131988AbRCVKrt>; Thu, 22 Mar 2001 05:47:49 -0500
Received: from [216.52.49.35] ([216.52.49.35]:37647 "HELO infbosvw.inf.com")
	by vger.kernel.org with SMTP id <S131985AbRCVKrg>;
	Thu, 22 Mar 2001 05:47:36 -0500
Message-ID: <426C1E9EBA27D411839000D0B74752F8015D2C38@punmsg02.ad.infosys.com>
From: nomit kalidhar <nomit_kalidhar@infy.com>
To: "'Manoj Sontakke'" <manojs@sasken.com>, linux-kernel@vger.kernel.org
Subject: RE: Fib entries
Date: Thu, 22 Mar 2001 15:36:18 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

It is for all the three cases.
It also contains for the case in which it does not match any one of them
that is the default entry.


Warm Regards,
Nomit Kalidhar,
Infosys-West, Pune.
ph  925-32801
Extn. 2293

------------------------------------------------------------------------
------------------------------------
	 Work like you never tire
	Love like you've never been hurt
	Dance like nobody is watching





-----Original Message-----
From: Manoj Sontakke [mailto:manojs@sasken.com]
Sent: Thursday, March 22, 2001 8:15 PM
To: linux-kernel@vger.kernel.org
Subject: Fib entries


Hi
	I have a question related to forwarding information base(FIB).

Depending upon destination IP address a packet can be 
a) for this machine
b) for a machine to which this machine is directly connected
c) for a machine to which this machine is not directly connected.

Does FIB contain the entries for delivery for all the 3 cases or only for
the third case

Thanks in advance for all the help

Manoj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
