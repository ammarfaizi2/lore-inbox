Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUB2L5s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 06:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUB2L5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 06:57:48 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:16581 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262031AbUB2L5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 06:57:47 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Date: Sun, 29 Feb 2004 11:57:45 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 - 8139too timeout debug info
Message-ID: <4041D3B9.24667.2D4E3207@localhost>
In-reply-to: <87fzcut9ua.fsf@devron.myhome.or.jp>
References: <4041BAA6.28283.2CEC419B@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Please try,
> 
> 	8139too-debug + 8139too-revert01
> 
> and if it still is the same,
> 
> 	8139too-debug + 8139too-revert01 + 8139too-revert02
> 

OK, I have patched as asked, and still get the problem.

Information here, 2 new files:

http://www.linicks.net/8139too_debug/

debug_with_patch01.txt

&

debug_with_patch01_patch02.txt

Thank you for your time in this.

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."

