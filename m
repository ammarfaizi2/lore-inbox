Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUKET5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUKET5c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUKET5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:57:31 -0500
Received: from mail.linicks.net ([217.204.244.146]:33289 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261197AbUKET4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:56:13 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: ext2/3 issue 2.6 vs 2.4 kernels
Date: Fri, 5 Nov 2004 19:56:11 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411051956.11505.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not know if this is related, but input anyway.

I moved from RH 2.4.x kernel -> 2.6.x. kernel on my box.  After a lot of 
upgrades to most system stuff
 
( http://www.hantslug.org.uk/cgi-bin/wiki.pl?LinuxHints/RedHat_2.4_To_2.6_Kernel_Upgrade )

I found FDISK broke and reported wrong disk sectors etc.  A lot of Googling 
revealed it was indeed a bug of sorts (I think), and an upgrade sorted it 
(file-utils)

Now whether FDISK is used in this I do not know.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
