Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVAMWOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVAMWOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVAMWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:14:05 -0500
Received: from mail.linicks.net ([217.204.244.146]:10116 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261728AbVAMV4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:56:25 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc randomly crashes on my PowerBook with recent kernels...
Date: Thu, 13 Jan 2005 21:56:13 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132156.13504.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not run said machine, but I did have GCC crashes under similar large 
builds (notably the kernel) on one of my boxes.

It turned out the CPU was overheating and investigation revealed the heatsink 
paste was dried out (it is an old box, circa 1998 since paste was applied). 

As I only loaded the thing during GCC builds is why the problem revealed it's 
self.  A new heatsink and paste fixed it.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
