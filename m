Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270472AbTGUQ20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270478AbTGUQ20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:28:26 -0400
Received: from law11-oe21.law11.hotmail.com ([64.4.16.125]:49680 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270472AbTGUQ2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:28:25 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with kernel 2.5.75 (Urgent)
Date: Mon, 21 Jul 2003 10:43:25 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE21KRfcjcMzf0000fbd6@hotmail.com>
X-OriginalArrivalTime: 21 Jul 2003 16:43:27.0340 (UTC) FILETIME=[359202C0:01C34FA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I compiled kernel version 2.5.75, before I had kernel 2.4.20, the problem is
that I need to enable SCSI DC395x, but when I execute lsmod I not found
neither modules loaded, only appear:
Module                  Size  Used by

If I mount manually a module (insmod
/lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko) the following message
appear: Error inserting
'/lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko': -1 Unknown symbol in
module, I have my modules.conf in the directory /lib/modules/2.5.75/ but
this kernel no load automatically the modules.

I need to load this module because Ineed to use the tape backup, I have a
backu that I need urgent.

How can I do it?

Thanks,
