Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310283AbSCLBGd>; Mon, 11 Mar 2002 20:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310280AbSCLBGV>; Mon, 11 Mar 2002 20:06:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32017 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310279AbSCLBGH>; Mon, 11 Mar 2002 20:06:07 -0500
Subject: Re: [BETA] First test release of Tigon3 driver
To: tngo@broadcom.com (Timothy Ngo)
Date: Tue, 12 Mar 2002 01:21:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, tngo@broadcom.com, gignatin@broadcom.com,
        gyoung@broadcom.com
In-Reply-To: <030801c1c960$ed24f470$f665030a@lt-ir002050.broadcom.com> from "Timothy Ngo" at Mar 11, 2002 04:57:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kaz3-0002P6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> different styles to writing a device driver, not just the style advocated by
> a couple of arrogant Linux people.

Documentation/CodingStyle

Its the standard everyone holds to, be they Dave Miller or IBM Corp. If
you wan't your driver in the main tree then its not something you need
to care about

The standard held for the mainstream kernel are very high - and they need
to be. Nobody makes you hold to it, and in fact that you have written a 
GPL driver is great - whatever it looks like. Its allowed those people who
do care to not only bitch about it but to actually go and try and do a
better job - at their own expense not yours.

Alan

