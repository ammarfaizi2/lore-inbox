Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUKNRB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUKNRB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 12:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUKNRB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 12:01:28 -0500
Received: from mail.linicks.net ([217.204.244.146]:52493 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261314AbUKNRB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 12:01:26 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling RHEL WS Kernels
Date: Sun, 14 Nov 2004 17:01:24 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411141701.24236.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2 boxes running RHEL ES at work, and I installed it on my laptop (a 
cheap Advert thing).  The soundcard didn't work, and USB went wonky.

So I tried to build a new kernel, and that was it, almost every module broke.  
I messed about for ages, but never got it right.

I fixed it by installing Slackware 10 instead...

I am sure with RHEL there is an extra step somewhere to build a kernel 
properly.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
