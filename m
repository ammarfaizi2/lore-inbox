Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319095AbSHSWyz>; Mon, 19 Aug 2002 18:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319098AbSHSWyz>; Mon, 19 Aug 2002 18:54:55 -0400
Received: from [209.47.40.2] ([209.47.40.2]:42505 "EHLO mailnet.consensys.com")
	by vger.kernel.org with ESMTP id <S319095AbSHSWyy>;
	Mon, 19 Aug 2002 18:54:54 -0400
Message-ID: <033f01c247d4$1abd5610$4902a8c0@consensys.com>
From: "Jason Zebchuk" <jason@consensys.com>
To: <linux-kernel@vger.kernel.org>
Subject: SE7500CW2 motherboard
Date: Mon, 19 Aug 2002 18:59:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I'm having problems with the kernel debugger on a number of machines
with Intel SE7500CW2 motherboards.

    When attempting to enter the debugger, either by pressing "PAUSE" or at
a breakpoint, one of  four things will happen:

    1.  It works as expected.

    2. It reboots.

    3.  It hangs.  ie. input seems to have no effect, no signs of activity,
forced to power down.

    4.  It prints:

            PCI System Error on Bus/Device/Function 00B0h
            PCI Parity Error on Bus/Device/Function 00B0h

        and then continues to function as expected.


    In addition, it also occasionally hangs or reboots after entering the
debugger successfully and using it for a short while.


    I'm using a 2.4.18 kernel, and the problems are only happening on Intel
SE7500CW2 motherboards (ie.  I don't have problems on say an Intel SDS2).

    Has anyone seen any similar problems?  Has anyone had problems using
this motherboard?  Does anyone have any suggestions?

Thanks,

Jason Zebchuk

