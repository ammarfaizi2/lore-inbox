Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKHTQ5>; Wed, 8 Nov 2000 14:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbQKHTQv>; Wed, 8 Nov 2000 14:16:51 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:31227 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S129148AbQKHTQj>;
	Wed, 8 Nov 2000 14:16:39 -0500
Message-Id: <4.3.2.7.2.20001108141644.00ac2350@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 08 Nov 2000 14:19:00 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: Installing kernel 2.4
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might be convenient to have a completely unoptimized 386 kernel.  While 
this would obviously be non-optimal in all cases, it would be compatible 
with everything and probably faster on non-386 than a 386-optimized 
kernel.  Of course, the gains are probably not worth the time it would take 
to write one, as I would hope that most linux users are willing to compile 
their own kernels...

--
This message has been brought to you by the letter alpha and the number pi.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
