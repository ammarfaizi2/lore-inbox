Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUHHL1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUHHL1n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 07:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUHHL1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 07:27:43 -0400
Received: from oliv.bezeqint.net ([192.115.104.12]:50122 "EHLO
	oliv.bezeqint.net") by vger.kernel.org with ESMTP id S265256AbUHHL1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 07:27:42 -0400
Date: Sun, 8 Aug 2004 14:29:02 +0300
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: no input with kernel 2.6.8-rc3-mm1 and X
Message-ID: <20040808112901.GA2958@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.6.8-rc3-mm1 I lose input completely the moment I start
X. Keyboard is completely non-functional (include sysrq and num/ctrl
lock) and the touchpad also doesn't seem to produce anything.

The computer is otherwise functional and I can ssh in from another
machine and chvt to the console where I get the keyboard back. chvt
back to X kills input again.

Input is completely function in the console and with kernel 2.6.8-rc2
also with X, so I don't think its an X configuration problem.
