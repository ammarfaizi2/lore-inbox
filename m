Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTINTA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTINTA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:00:28 -0400
Received: from web21106.mail.yahoo.com ([216.136.227.108]:839 "HELO
	web21106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261270AbTINTAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:00:17 -0400
Message-ID: <20030914190015.49006.qmail@web21106.mail.yahoo.com>
Date: Sun, 14 Sep 2003 12:00:15 -0700 (PDT)
From: Pat LaVarre <p_lavarre@yahoo.com>
Reply-To: p.lavarre@ieee.org
Subject: RE: 2.6.0-test5: intermittent crash on chvt to X; was console lost to Ctrl+Alt+F$n in 2.6.0-test5
To: mhf@linuxmail.org
Cc: mpm@selenic.com, p.lavarre@ieee.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If it is specific to -test5, post (as tar.bz2)

Definitely not specific to 2.6.0-test5: I have
repeatedly seen 2.6.0-test4 crash this way too.

Whether I have had this vulnerability for days or
weeks or months or years I am not yet sure, I do not
customarily make a point of trying chvt much with each
new kernel.  

Unless I hear otherwise, hopefully within hours, when
next I manage to visit my console in person:

1) I will test to see if the script can crash:

2.6.0-test4 with my near default .config
2.4.22 with my near default .config
2.4.21-xfs Knoppix booted via cd

2) After the reboot following a crash of 2.6.0-test5 I
will sample:

lspci -v
/var/log/dmesg
X version and driver info from /var/log/XFree86.log 
.config

3) I will report back here, attaching (2) as .tar.bz2.

Pat LaVarre



__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
