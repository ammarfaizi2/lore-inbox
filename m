Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbQKLAvJ>; Sat, 11 Nov 2000 19:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQKLAu6>; Sat, 11 Nov 2000 19:50:58 -0500
Received: from [63.95.244.10] ([63.95.244.10]:4544 "EHLO mailhub.webgain.com")
	by vger.kernel.org with ESMTP id <S129339AbQKLAun>;
	Sat, 11 Nov 2000 19:50:43 -0500
Message-Id: <5.0.0.25.0.20001111164600.034bb640@stargate>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Sat, 11 Nov 2000 16:49:54 -0800
To: kuznet@ms2.inr.ac.ru
From: Thomas Pollinger <tpolling@rhone.ch>
Subject: Re: [BUG REPORT] TCP/IP weirdness in 2.2.15
Cc: linux-kernel@vger.kernel.org, davem@redhat.com (Dave Miller)
In-Reply-To: <200011111705.UAA04570@ms2.inr.ac.ru>
In-Reply-To: <5.0.0.25.0.20001106111445.034a8660@stargate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>Hello!
>
>172.30.0.3 is HPUX?

Hello Alexey,
yes, this is the HPUX.

>Upgrade it, you were so unlucky to purchase some invalid OS release.
>Each TCP connection to it from any sane OS will freeze miximum after
>656 seconds.

Thanks for the hint. This stroke me as well as I left it once the whole 
night and the server did not terminate the connection.


>I think this bug has been fixed.

Just out of curiosity, was that bug related to a special configuration with 
the HPUX or could it have happened between two Linux boxes as well?

-Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
