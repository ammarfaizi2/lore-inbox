Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262421AbRFGKRh>; Thu, 7 Jun 2001 06:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264384AbRFGKR1>; Thu, 7 Jun 2001 06:17:27 -0400
Received: from oe-iw1pub.managedmail.com ([206.46.164.32]:18588 "EHLO
	oe-iw1.bizmailsrvcs.net") by vger.kernel.org with ESMTP
	id <S262421AbRFGKRV>; Thu, 7 Jun 2001 06:17:21 -0400
Reply-To: <clive.jordan@openwave.com>
From: "Clive Jordan" <clive.jordan@openwave.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.4 fails to boot [FIXED]
Date: Thu, 7 Jun 2001 11:21:21 +0100
Message-ID: <000101c0ef3b$9975d880$3a7078d5@cjordan>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3B1EB79C.29E4AE2C@resilience.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help guys.

> I cannot get a newly compiled 2.4.4 kernel to boot.
> Fails at:
>
> Loading linux .......
> Uncompressing Linux... Ok, booting kernel.
>
> <then it hangs>

It was a combination of VGA console support and incorrect processor type as
you suggested.

Cheers,
Clive


