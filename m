Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFVGw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 02:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFVGwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 02:52:55 -0400
Received: from deepthot.org ([216.19.203.209]:56488 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S261741AbTFVGwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 02:52:54 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Redhat 2.4.20 kernel problems
Date: Sun, 22 Jun 2003 06:55:35 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbfakn7.hsl.denebeim@hotblack.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case anyone is still interested, I finally got around to trying a
kernel.org 2.4.20 version.  No problem.  So it's not in the kernel
tree.  I compiled it using the /boot/config-2.4.20(whatever) that
Redhat shipped, so it's not a module/option issue.  The kernel was
signifigantly smaller than the redhat one as well by several hundred
K.

The problem was this, under the redhat kernel shipped on CD for redhat
9 and updated for redhat 8 my SO's computer locks up when she moves
her mouse after booting.  It's a USB mouse.  The system just freezes.

I haven't seen an Ooops or anything like that.  The syslog is
forwarded over tcp to my system, so I may see it even with the lock
up.

I assume the problem is a lost interrupt or something along that line,
but this is just a gut feeling.

How should I contact redhat about this issue?  It's going to be a
problem upgrading her system if she can't run a stock kernel.  I tried
writing a friend of mine at Redhat Erik Troan, but his old redhat
address doesn't work any more.

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
