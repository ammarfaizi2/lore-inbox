Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131047AbQKPQgc>; Thu, 16 Nov 2000 11:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbQKPQgW>; Thu, 16 Nov 2000 11:36:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46902 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130747AbQKPQgJ>; Thu, 16 Nov 2000 11:36:09 -0500
Subject: Re: APM oops with Dell 5000e laptop
To: dax@gurulabs.com (Dax Kelson)
Date: Thu, 16 Nov 2000 16:06:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0011131537460.27682-100000@ultra1.inconnect.com> from "Dax Kelson" at Nov 13, 2000 03:54:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wRYd-0007yS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just got a Sceptre 6950 (also known as a Dell 5000e), I just installed
> Red Hat 7.0 on it, and got an APM related oops at boot.

Yep. This is not a Linux problem

> Here is what got in /var/log/messages, I'm willing to try suggested fixes,
> etc.  The problem also happens with the 2.4 test kernels.

There are no fixes. Return the faulty equipment to the vendor and suggest
they get a QA department. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
