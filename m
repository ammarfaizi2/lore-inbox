Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129986AbRBOUdk>; Thu, 15 Feb 2001 15:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbRBOUdU>; Thu, 15 Feb 2001 15:33:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53001 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130000AbRBOUdT>; Thu, 15 Feb 2001 15:33:19 -0500
Subject: Re: 2.4.1ac13/14 problem
To: foka@ualberta.ca (Anthony Fok)
Date: Thu, 15 Feb 2001 20:33:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        soci@singular.sch.bme.hu (Kajtar Zsolt), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.10.10102151322330.19842-100000@gpu2.srv.ualberta.ca> from "Anthony Fok" at Feb 15, 2001 01:26:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TV5f-0000p1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't tried 2.4.1-ac13 on that machine yet, but I did attempt to boot
> 2.4.1-ac13 on an Winchip-C6 machine.  It froze at the same place, i.e.
> "Checking if this processor honours the WP bit even in supervisor
> mode...".  2.4.1-ac12 works quite nicely on this machine, although I still

Now thats interesting. And also useful because I've not touched the winchip
code paths. Also I have an IDT winchip t frob with.

> 

