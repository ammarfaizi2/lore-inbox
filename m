Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOWTe>; Fri, 15 Dec 2000 17:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbQLOWTZ>; Fri, 15 Dec 2000 17:19:25 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:50955 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129340AbQLOWTQ>; Fri, 15 Dec 2000 17:19:16 -0500
Message-ID: <3A3A9FE3.ECADF36@t-online.de>
Date: Fri, 15 Dec 2000 23:49:07 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lx240test12 hangs VAIO after "OK, booting the kernel"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Linux-2.4.0-test12 doesn't boot on VAIO PCG-N505SN,
whereas linux-2.2.10 works fine (both booted by lilo-21).

It just hangs after printing:
Uncompressing Linux... Ok, booting the kernel.
HANG

Btw. Raw bzImage booted over USB-floppy just reboots...

Can this be infamous A20 again ?

Regards, Gunther
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
