Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVAQIrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVAQIrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVAQIrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:47:14 -0500
Received: from pcsbom.patni.com ([203.124.139.208]:45614 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S262727AbVAQIrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:47:11 -0500
Reply-To: <sujeet.kumar@patni.com>
From: "Sujeet Kumar" <sujeet.kumar@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: ioctl flow change in kernel 2.6
Date: Mon, 17 Jan 2005 14:21:57 +0530
Message-ID: <007701c4fc71$ce040350$7861a8c0@pcp40702>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1105951556-1420-196"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1105951556-1420-196
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the flow of ioctl in kernel 2.6 .  it handles
for the generic implementations first and if not found then driver
specific (like BLKRRPART).

I am trying a pseudo driver over a block driver which will handle the
generic ioctls.

Is there a way I can handle BLKRRPART from my pseudo driver if I want to ?

Thanks & regards ,
sujeet kumar




http://www.patni.com
World-Wide Partnerships. World-Class Solutions.
_____________________________________________________________________

This e-mail message may contain proprietary, confidential or legally
privileged information for the sole use of the person or entity to
whom this message was originally addressed. Any review, e-transmission
dissemination or other use of or taking of any action in reliance upon
this information by persons or entities other than the intended
recipient is prohibited. If you have received this e-mail in error
kindly delete  this e-mail from your records. If it appears that this
mail has been forwarded to you without proper authority, please notify
us immediately at netadmin@patni.com and delete this mail. 
_____________________________________________________________________

------------=_1105951556-1420-196--
