Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbUKRG36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbUKRG36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUKRG35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:29:57 -0500
Received: from [203.200.194.71] ([203.200.194.71]:23183 "EHLO
	semsoftindia-samsung.com") by vger.kernel.org with ESMTP
	id S262614AbUKRG3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:29:55 -0500
Reply-To: <srinivas@semsoftindia-samsung.com>
From: "Srinivas Naga Vutukuri" <srinivas@semsoftindia-samsung.com>
To: <linux-kernel@vger.kernel.org>
Subject: Ack Flooding
Date: Thu, 18 Nov 2004 11:59:49 +0530
Message-ID: <HEEPIMMIBFKCAGHPIBKDAEKMCAAA.srinivas@semsoftindia-samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
            
       Am just looked at the tcp_input.c
will it serve in modifying the function, tcp_rcv_established()
calling tcp_send_ack() inside it places 3 or 5 times,


Regards,
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
