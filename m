Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRFWImJ>; Sat, 23 Jun 2001 04:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263756AbRFWIl7>; Sat, 23 Jun 2001 04:41:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263766AbRFWIlo>; Sat, 23 Jun 2001 04:41:44 -0400
Subject: Re: ACPI or Advanced power ...
To: john@grulic.org.ar (John R Lenton)
Date: Sat, 23 Jun 2001 09:40:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), haiquy@yahoo.com (Steve Kieu),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20010623033630.B830@grulic.org.ar> from "John R Lenton" at Jun 23, 2001 03:36:30 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DiyR-0004yn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree ACPI sucks, but I have a SMP box that I need to be able to
> powerdown remotely. Is there any reason APM can't do that? I mean, I
> understand APM was never meant for SMP, but... ?

You can tell 2.4 to do APM poweroffs on SMP boxes. It works for most BIOSes
