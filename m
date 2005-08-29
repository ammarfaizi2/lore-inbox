Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVH2R53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVH2R53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVH2R53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:57:29 -0400
Received: from mail.linicks.net ([217.204.244.146]:46855 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751251AbVH2R50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:57:26 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 new option timer frequency
Date: Mon, 29 Aug 2005 18:57:15 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508291857.15746.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I built and installed 2.6.13 today, and oldconfig revealed the new option for 
timer frequency.

I searched the LKML on this, but all I found is the technical stuff - not 
really any layman solutions.

Two n00b questions here:

What does this do/what is it for?

I selected default, 250Hz.  If this is now an option, what was it before?

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
