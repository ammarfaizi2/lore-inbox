Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132658AbRDCHRy>; Tue, 3 Apr 2001 03:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132663AbRDCHRo>; Tue, 3 Apr 2001 03:17:44 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14598 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132658AbRDCHRl>; Tue, 3 Apr 2001 03:17:41 -0400
Date: Tue, 03 Apr 2001 10:16:53 +0200
From: Andreas Rogge <lu01@rogge.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Strange Syslog-Entry and Machine Lockup
Message-ID: <26860000.986285813@hades>
In-Reply-To: <200104030659.f336xff02242@mobilix.atnf.CSIRO.AU>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.4.2 to 2.4.3 with jfs 0.2.1 my machine died last 
night.
The last messages in syslog were:
Apr  3 01:35:01 hades kernel: Unable to handle kernel paging request at 
virtual
address 8d0800c0
Apr  3 01:35:01 hades kernel: *pde = 00000000
Apr  3 01:35:01 hades kernel: Unable to handle kernel paging request at 
virtual address 8d0800b8
Apr  3 01:35:01 hades kernel: *pde = 00000000

And the last application message was:
Apr  3 01:35:01 hades gnome-name-server[225]: input condition is: 0x11, 
exiting


Does anyone have a clue what this means?

Regards,
	Andreas
