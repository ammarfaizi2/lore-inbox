Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUHXCBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUHXCBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHXCBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:01:49 -0400
Received: from h-66-166-151-206.snvacaid.covad.net ([66.166.151.206]:24589
	"EHLO menlomart.com") by vger.kernel.org with ESMTP id S268129AbUHXB50
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:57:26 -0400
Message-ID: <006d01c4897d$ab8bce00$1000a8c0@websys>
From: "Karthi Jothi" <karthi@onspecinc.com>
To: <linux-kernel@vger.kernel.org>
Subject: Need help in mounting two-LUN atapi flash card reader
Date: Mon, 23 Aug 2004 18:57:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-MDRemoteIP: 66.166.151.202
X-Return-Path: karthi@onspecinc.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
Need help in mouting two-LUN atapi flash card reader. 
 
Linux Distribution - Redhat 8.0
Kernal version - 2.4.18-14

Details about the device attempting to mount:

1.  The device used for mounting is a Atap flash card reader and it is not
an USB device.  It uses 40-PIN ide connector and cable. It is connected as
secondary master to the linux system.

2.  Size of the device matches to that off floppy drive.  It has one
connector for CompactFlash --- for LUN0  and second connector for
SmartMedia/MMC/MS --- for LUN1.

Appreciate your help.
 
With best regards
Karthi

With best regards,
Karthi
OnSpec Electronic Inc


