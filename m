Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUAOHQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbUAOHQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:16:47 -0500
Received: from web11904.mail.yahoo.com ([216.136.172.188]:34063 "HELO
	web11904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264905AbUAOHQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:16:46 -0500
Message-ID: <20040115071645.67686.qmail@web11904.mail.yahoo.com>
Date: Wed, 14 Jan 2004 23:16:45 -0800 (PST)
From: roshan mulla <mullaroshan@yahoo.com>
Subject: mouse driver 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 hello ,
   I am trying to develop a mouse driver on linux red
hat 9 on kernel 2.4.20-8 . I am using  mouse driver
code by Alan Cox available on the web. I could
successfully compile the code .
My machine is using PS/2 mouse.i reboot the machine
with mouse removed it asks me for remove
configuration.
After this when i insmod the driver and do mknod .when
i try to open this device it gives me kernel panic
giving messages as interrupt not syncing. 
 Please can u tell me as to do i test this code . Do i
need to do some special kernel configuration for
testing this code. 
 I desperately need to test this code for my project. 
It would be very kind of u if u could help me in this
matter.
 looking forward to ur reply    
                  roshan



__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
