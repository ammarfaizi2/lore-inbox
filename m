Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUHVI4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUHVI4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 04:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUHVI4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 04:56:07 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:10749 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S266543AbUHVI4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 04:56:00 -0400
Subject: [Transmeta hardware] Update of the CMS under Linux ?
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Aalborg University
Message-Id: <1093165082.11189.20.camel@aphrodite.olympus.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 10:58:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to know if there is any hope to have a software that allow
us to update the Transmeta CMS (Code Morphing Software) from Linux ?

I tried to google around but I never managed to find something valuable.
The only valuable link seems to be this one:
http://h18007.www1.hp.com/support/files/compaqtabletpc/us/download/18120.html

So, it seems to be possible.

I have a CMS 4.3.2 on my computer (see below) but the 4.4 is now out
(see: http://www.theinquirer.net/?article=8071 or
http://www.realworldtech.com/page.cfm?ArticleID=RWT010204000000&p=3 ,
first sentence) and I think there is a bug in the one I have (see:
http://freedesktop.org/bugzilla/show_bug.cgi?id=455).

My version of the CMS is: 
CPU: After generic identify, caps: 0080893f 0081813f 00000000 00000000
CPU: After vendor identify, caps:  0080893f 0081813f 0000004e 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.4.1.0, 933 MHz
CPU: Code Morphing Software revision 4.3.2-9-343
CPU: 20020426 17:54 official release 4.3.2#2
CPU: After all inits, caps:        0080893f 0081813f 0000004e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5800 stepping 03



See also:
http://www.leog.net/fujp_forum/topic.asp?ARCHIVE=true&TOPIC_ID=2159

Regards
-- 
Emmanuel Fleury
 
Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

