Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWDYSFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWDYSFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWDYSFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:05:22 -0400
Received: from mail.linicks.net ([217.204.244.146]:23777 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932120AbWDYSFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:05:21 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: scheduler question 2.6.16.x
Date: Tue, 25 Apr 2006 19:05:18 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251905.19004.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I see in menuconfig I have two options:

<*> Anticipatory I/O scheduler
<*> Deadline I/O scheduler

Help reveals Anticipatory is pretty good, but make a slightly larger kernel - 
Deadline help says it a good alternative to Anticipatory.

But I can build both in... so I guess then the kernel decides what is the best 
to use?  Or should it be so I am only allowed to select one or the other and 
allowing both is an oversight?

Thanks,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
