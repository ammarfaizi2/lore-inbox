Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUJSG2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUJSG2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 02:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUJSG2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 02:28:52 -0400
Received: from [203.200.194.71] ([203.200.194.71]:12863 "EHLO
	semsoftindia-samsung.com") by vger.kernel.org with ESMTP
	id S268035AbUJSG2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 02:28:50 -0400
Reply-To: <srinivas@semsoftindia-samsung.com>
From: "Srinivas Naga Vutukuri" <srinivas@semsoftindia-samsung.com>
To: <linux-kernel@vger.kernel.org>
Subject: DMA memory allocation --how to more than 1 MB
Date: Tue, 19 Oct 2004 11:58:16 +0530
Message-ID: <HEEPIMMIBFKCAGHPIBKDEEFFCAAA.srinivas@semsoftindia-samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  
I am just looking at the mail,
mentioned that using __get_free_pages(GFP_KERNEL, 8),
its possible... lets check it out...
  
http://www.spinics.net/lists/newbies/msg12638.html
 

regards,
srinivas.

********************************************************************
No virus was detected in the attachment no filename

Your mail has been scanned by InterScan.
********************************************************************


The information contained in this electronic message and any attachments 
to this message are intended for the exclusive use of the addressee(s) 
and may contain confidential or privileged information.
If you are not the intended recipient, please notify the sender at 
Samsung Electro-Mechanics Co. Ltd. or admin@semsoftindia-samsung.com
immediately and destroy all copies of this message and any attachments.
Any unauthorized review, use, disclosure, dissemination, forwarding, 
printing or copying of this email or any action taken in reliance on
this e-mail is strictly prohibited and may be unlawful.
