Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264563AbSIVVz1>; Sun, 22 Sep 2002 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264565AbSIVVz1>; Sun, 22 Sep 2002 17:55:27 -0400
Received: from web40503.mail.yahoo.com ([66.218.78.120]:54276 "HELO
	web40503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264563AbSIVVz0>; Sun, 22 Sep 2002 17:55:26 -0400
Message-ID: <20020922220031.62365.qmail@web40503.mail.yahoo.com>
Date: Sun, 22 Sep 2002 15:00:31 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: scsi error.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting my system I got the following error while my
IDE drive was being fsck'd:

Sep 22 17:48:52 test kernel: scsi0: PCI error Interrupt at seqaddr = 0x8
Sep 22 17:48:52 test kernel: scsi0: Data Parity Error Detected during address or write data phase

None of my SCSI drives had been mounted.

I'm running 2.4.19ac4. My hardware: Adaptec 29160 with 3 Maxtor Atlas III drives
(2 internal and one external). 

The error did not repeat, and I seem to be able to access my SCSI drives with no problem.
Is this error anything to worry about?

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
