Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbULESIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbULESIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULESIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:08:31 -0500
Received: from mail.linicks.net ([217.204.244.146]:34564 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261320AbULESIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:08:30 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ethX interface rx errors
Date: Sun, 5 Dec 2004 18:08:28 +0000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412051808.28277.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an idea for you to look at...

I had a peculiar problem once on my 8139too NIC's, and it was a setting in 
BIOS.  After a lot of debugging, the resolution can be found here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107919285122190&w=2

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
