Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbRCAP33>; Thu, 1 Mar 2001 10:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbRCAP3T>; Thu, 1 Mar 2001 10:29:19 -0500
Received: from [62.90.5.51] ([62.90.5.51]:35079 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129639AbRCAP3H>;
	Thu, 1 Mar 2001 10:29:07 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DECE@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Intel-e1000 for Linux 2.0.36-pre14
Date: Thu, 1 Mar 2001 17:33:46 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to compiled e1000 for Linux 2.0.36-pre14, I can also load it
successfully. 
With the E1000_IMS_RXSEQ bit set in IMS_ENABLE_MASK I get endless interrupts
and the computer freezes, without this bit set it works but I cannot receive
or send anything.

Does any one have a clue?.
Thanks
Ofer
