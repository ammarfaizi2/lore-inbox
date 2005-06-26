Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVFZPDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVFZPDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFZPDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 11:03:31 -0400
Received: from mail.linicks.net ([217.204.244.146]:15378 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261303AbVFZPD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 11:03:29 -0400
From: Nick Warne <nick@linicks.net>
To: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: 8139too PCI IRQ issues   WAS Re: 2.6.12 breaks 8139cp
Date: Sun, 26 Jun 2005 16:03:25 +0100
User-Agent: KMail/1.8.1
References: <200506261446.57802.nick@linicks.net> <42BEC2B6.6020905@comcast.net>
In-Reply-To: <42BEC2B6.6020905@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506261603.25402.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 15:59, you wrote:
> What are you supposed to do though if you dont have that bios option.
> And if the bios wasn't changed between kernel version upgrades, what is
> the PCI irq subsystem doing now that requires such a change? And what
> makes it possible to remove the problem with reverting just the 8139too
> driver ...   There is a quirk here, but the fix should be in the kernel,
> since not all bios' allow you to make the fix yourself.

Well, I wasn't saying _this_ is the solution, I was just pointing out the 
threads involved from last year for reference during this issue.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
