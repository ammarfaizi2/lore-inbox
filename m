Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131716AbQLPLki>; Sat, 16 Dec 2000 06:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbQLPLk2>; Sat, 16 Dec 2000 06:40:28 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:16908 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131717AbQLPLkR>; Sat, 16 Dec 2000 06:40:17 -0500
Message-ID: <3A3B5BA5.B0F5615@t-online.de>
Date: Sat, 16 Dec 2000 13:10:13 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RESOLVED: lx240test12 hangs VAIO: P-III kernel hangs on P-II
In-Reply-To: <3A3A9FE3.ECADF36@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
compiling the kernel for P-II resolved my problem.

What would be necessary to print an error message
instead of just hanging?

-
Gunther

Gunther Mayer wrote:
> 
> Hi,
> Linux-2.4.0-test12 doesn't boot on VAIO PCG-N505SN,
> whereas linux-2.2.10 works fine (both booted by lilo-21).
> 
> It just hangs after printing:
> Uncompressing Linux... Ok, booting the kernel.
> HANG
> 
> Btw. Raw bzImage booted over USB-floppy just reboots...
> 
> Can this be infamous A20 again ?
> 
> Regards, Gunther
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
