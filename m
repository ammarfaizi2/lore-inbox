Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVAENyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVAENyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVAENyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:54:11 -0500
Received: from pcsbom.patni.com ([203.124.139.208]:44455 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S262426AbVAENxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:53:50 -0500
Reply-To: <sujeet.kumar@patni.com>
From: "Sujeet Kumar" <sujeet.kumar@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: data rescue
Date: Wed, 5 Jan 2005 19:29:14 +0530
Message-ID: <00e801c4f32e$bde1e600$7861a8c0@pcp40702>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1104933705-24057-258"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1104933705-24057-258
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



I ran
blockdev -v --rereadpt ....
on my harddisk .
It gave re-read partition succeded. Then after rebooting the machine it
shows no partitions.

I tried running linux-rescue from bootable disk and it shows no valid
partition table.
How do i rescue my data . Tell me what rereadpt basically does













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

------------=_1104933705-24057-258--
