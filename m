Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKPFSW>; Thu, 16 Nov 2000 00:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129522AbQKPFSN>; Thu, 16 Nov 2000 00:18:13 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:25817 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S129187AbQKPFSE>;
	Thu, 16 Nov 2000 00:18:04 -0500
Message-Id: <4.3.2.7.2.20001115234630.00b1e850@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 15 Nov 2000 23:51:02 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: 2.4. continues after Aieee...
In-Reply-To: <200011151630.RAA04141@cave.bitwizard.nl>
In-Reply-To: <5.0.0.25.0.20001115111100.03572eb0@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:30 PM 11/15/2000 +0100, Rogier Wolff wrote:

> > network card driver) and leave the system running make linux unusable in
> > unattended environments as the machine is functionally dead.
>
>Which doesn't help in this case, as your network card COULD be dead,
>while the system simply hasn't crashed....

Yeah, but it doesn't matter.  The system is no more useful running with a 
network card than it is rebooting itself.  Just make sure that it doesn't 
reboot itself more than N times in M hours, and you'll be fine...   The 
network admin needs to be paged in any case. The network card COULD be 
dead, in which case the administrator needs to replace it.  Otherwise, a 
reboot could solve the problem.

--
This message has been brought to you by the letter alpha and the number pi.
Open Source: Think locally, act globally.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
