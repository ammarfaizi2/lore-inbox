Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUHEAip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUHEAip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 20:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUHEAip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 20:38:45 -0400
Received: from web51801.mail.yahoo.com ([206.190.38.232]:22112 "HELO
	web51801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267526AbUHEAin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 20:38:43 -0400
Message-ID: <20040805003843.33108.qmail@web51801.mail.yahoo.com>
Date: Wed, 4 Aug 2004 17:38:43 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Controlling PCI device enumeration
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there any way to controll bus enumeration at boot
time?

I am using 2.6.7 and 8.  The issue is I have a system
with 2 FC cards that are enumerated first before the
on board controller (scsi).  I need to know how to
make sure that:
1> the on board controller is first (so I can boot
properly)
2> make sure the FC cards are always enumerated in the
same order.

Thanks you for your help.
Phy


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
