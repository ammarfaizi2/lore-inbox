Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADOv2>; Thu, 4 Jan 2001 09:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADOvT>; Thu, 4 Jan 2001 09:51:19 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:34244 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129267AbRADOvL>; Thu, 4 Jan 2001 09:51:11 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>, <dledford@redhat.com>
Subject: Re: aic7xxx.c vs. Adaptec 29160N
Date: Thu, 4 Jan 2001 15:50:52 +0100
Message-Id: <19341129082236.10998@mailhost.mipsys.com>
In-Reply-To: <19341129080544.842@mailhost.mipsys.com>
In-Reply-To: <19341129080544.842@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Anything I can do to help tracking the problem ? It's difficult to get
>the actual output of the driver in verbose mode as it is scrolling quite
>fast and I have nothing like a serial console on this box. The kernel
>won't boot without noprobe so I can't dump dmesg output.

I was wrong, even no_probe won't help, I have to physically disconnect
the drive to get the kernel to boot.

Ben.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
