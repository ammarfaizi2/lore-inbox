Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbRFBWpk>; Sat, 2 Jun 2001 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbRFBWpa>; Sat, 2 Jun 2001 18:45:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18193 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261988AbRFBWpR>; Sat, 2 Jun 2001 18:45:17 -0400
Subject: Re: Date goes four times faster!
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Date: Sat, 2 Jun 2001 23:43:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <E156K3F-0002FV-00@the-village.bc.nu> from "Dieter =?iso-8859-1?q?N=FCtzel?=" at Jun 03, 2001 12:51:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E156K7D-0002Fn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use your -ac series ever (did I? :-) but I am under the impression that my 
> hardware clock (date in the long run) is running (little) to fast.

Well that would probably imply the clock is out on the machine - which with
modern systems is not that unusual.  You can tune the clock slide with adjtimex
> 
> Athlon I 550 (0.25 µm)
> MSI MS-6167 (AMD Irongate C4) --- Yes, Alan the very first one...;-)

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 23)

and my clock does behave..

> ACPI anabled...

Brave man 8)

Alan

