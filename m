Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVHWNOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVHWNOW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVHWNOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:14:21 -0400
Received: from tag.witbe.net ([81.88.96.48]:63699 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932177AbVHWNOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:14:19 -0400
Message-Id: <200508231314.j7NDEGD09705@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.4.31] - USB device numbering in /proc/bus/usb
Date: Tue, 23 Aug 2005 15:14:38 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcWn5J1dxI6r/WbGSfmWkWUAcXrzDA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just rebooted a machine, and the eagle ADSL modem I was using,
presented as /proc/bus/usb/002/005 in now presented as 
/proc/bus/usb/002/003 (same bus, but device ID changed from 5 to 3).

Is this an expected behavior, when running a 2.4.31 kernel ?
I would have been expecting some more stability in the numbering across
reboot, the same way IDE disks numbers are stable.

Paul

