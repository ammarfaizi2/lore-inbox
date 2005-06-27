Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVF0UZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVF0UZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVF0UWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:22:55 -0400
Received: from mail.linicks.net ([217.204.244.146]:26383 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261689AbVF0UVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:21:12 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: A Bug in gcc or asm/string.h ?
Date: Mon, 27 Jun 2005 21:21:04 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506272121.04166.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive posting to this thread, but I had this issue a few weeks back.

I was messing about with my bespoke Quake2 Xatrix server code, and have added 
a lot of standard string functions  for speed and stuff.  I used a few from 
the linux kernel string functions.

Read the thread for what went on:

http://www.quakesrc.org/forums/viewtopic.php?t=5144

I don't expect a reason here, just I couldn't get it to work at all - but the 
assembler one did...

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
