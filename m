Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280678AbRKNQ2N>; Wed, 14 Nov 2001 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280680AbRKNQ2D>; Wed, 14 Nov 2001 11:28:03 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:20235 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S280678AbRKNQ1t>; Wed, 14 Nov 2001 11:27:49 -0500
Message-ID: <013d01c16d29$bc5d4380$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <tytso@mit.edu>, <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com> <3BF2947B.DF3BE9DC@mandrakesoft.com>
Subject: Re: Fw: [Patch] Some updates to serial-5.05
Date: Wed, 14 Nov 2001 11:30:56 -0500
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> Your code formatting is totally different from the formatting of the
> surrounding serial.c code you modify.

Please point out the bad parts. From my end the formatting is
exactly the same.

> Also, a diff against the kernel 2.4.x serial.c might be nice, as there
> haven't been updates from tytso in ages (serial-5.05), and rmk has a new
> serial driver for 2.5.x.

2.4.0 contains 5.02 and 2.4.14 contains 5.05c. These patches should
apply cleanly to all 5.xx serial drivers, although there may be
fuzz/offsets.

..Stu


