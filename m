Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUCXCrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 21:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbUCXCrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 21:47:19 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:5702
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262983AbUCXCrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 21:47:15 -0500
From: "Shawn Starr" <shawn.starr@rogers.com>
To: "'Kai Makisara'" <Kai.Makisara@kolumbus.fi>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive (HP Colorado T4000s) - Dump included now - Resolved
Date: Tue, 23 Mar 2004 21:50:43 -0500
Message-ID: <000001c4114a$cd3bb1b0$030aa8c0@PANIC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
In-Reply-To: <Pine.LNX.4.58.0403222004170.1092@kai.makisara.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [67.60.40.239] using ID <shawn.starr@rogers.com> at Tue, 23 Mar 2004 21:46:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I can confirm this is fixed in -bk2,-bk3

-----Original Message-----
From: Kai Makisara [mailto:Kai.Makisara@kolumbus.fi] 
Sent: Monday, March 22, 2004 01:05 PM
To: Shawn Starr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape
drive (HP Colorado T4000s) - Dump included now


On Sun, 21 Mar 2004, Shawn Starr wrote:

> Here is the captured dump, the st driver appears to be broken:
> 
Please try 2.6.5-rc2-bk2, it includes a change that should fix this.

-- 
Kai

