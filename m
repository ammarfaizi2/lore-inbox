Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVHBKWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVHBKWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVHBKWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:22:45 -0400
Received: from kalyani.insilicasemi.com ([203.145.179.171]:29382 "EHLO
	kalyani.insilicasemi.com") by vger.kernel.org with ESMTP
	id S261454AbVHBKWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:22:21 -0400
From: "Sudheer" <rsud@insilica.com>
To: "'Rahul Tank'" <rahul5311@yahoo.co.in>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: serial driver + ioctl
Date: Tue, 2 Aug 2005 15:52:05 +0530
Message-ID: <002401c5974c$0e143080$2f08a8c0@varuna>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050802094654.40456.qmail@web8410.mail.in.yahoo.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Refer any of the serial driver in the kernel source. There will be
defined register for this, you need to set those bits for your
requirement.

-Sudheer

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Rahul Tank
Sent: Tuesday, August 02, 2005 3:17 PM
To: ubuntu-users@lists.ubuntu.com; Linux-kernel
Subject: serial driver + ioctl

 hello all,
   i am trying to write an ioctl for my serial driver.
i am trying to implement a method which works like
'setserial' however i am unable to understand how to
set the baud rate .
  any pointers

 thanx in advance
  regards,
   rahul


	

	
		
__________________________________________________________
Free antispam, antivirus and 1GB to save all your messages
Only in Yahoo! Mail: http://in.mail.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


