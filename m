Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263306AbSJHT2S>; Tue, 8 Oct 2002 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbSJHT1C>; Tue, 8 Oct 2002 15:27:02 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:8860 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S263301AbSJHTZw>; Tue, 8 Oct 2002 15:25:52 -0400
Date: Tue, 08 Oct 2002 12:30:40 -0700
From: Iain McClatchie <iain@truecircuits.com>
Subject: SMP ACPI S3 support in 2.4 series?
To: linux-kernel@vger.kernel.org
Message-id: <3DA33260.BE383232@truecircuits.com>
Organization: True Circuits
MIME-version: 1.0
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18pre15 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm buying a number of SMP servers.  These machines will go
idle for days at a time, and we'd like to send them into a
suspend-to-RAM (ACPI state S3) while they are unused.

I want to know if this is even possible with the Linux 2.4
series kernels, and if so, which hardware and kernel combinations
support it.  I'd also like to know if anyone really has this
working right now.

As dual Athlon systems appear to be the best performance/$ for
my application, I'm especially interested in getting those to
sleep, but I'll take any pointers I can get.

-Iain McClatchie                       iain-3@truecircuits.com
                                       650-691-7604 voice
True Circuits, Inc.                    650-691-7606 FAX
                                       650-703-2095 cell
