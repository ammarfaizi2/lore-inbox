Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUHFFEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUHFFEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 01:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268091AbUHFFEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 01:04:08 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:31436 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S268089AbUHFFEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 01:04:05 -0400
Message-ID: <004101c47b73$4280a880$0300a8c0@r000000>
From: "Mike" <turbanator1@verizon.net>
To: <linux-kernel@vger.kernel.org>
Subject: USB2 DVD+R/RW Writer issues
Date: Fri, 6 Aug 2004 01:07:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.202.54.123] at Fri, 6 Aug 2004 00:04:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an external USB 2.0/Firewire HP DVD200E DVD+R/RW drive, connected to
my system through an after-market USB 2.0 card. My USB 2.0 card has a VIA
VT6212 chipset. I cannot use this drive when it is connected to the card.
DVDs will not read or write and CDs will not read or write. Attempting to
mount a DVD or a CD results in various errors being spit out. I have EHCI
compiled into my kernel, along with UHCI to support my system's stock USB
1.1 host controller (which works fine.) Additionally, USB Mass-Storage is
compiled into my kernel.

I have SCSI Generic and SCSI CDROM support compiled into my kernel as well.
I can provide any additional information upon request. Any information about
whether this is a known bug, or any assistance would be greatly appreciated.


