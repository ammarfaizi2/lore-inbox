Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTJLDmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 23:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTJLDmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 23:42:35 -0400
Received: from deepthot.org ([68.14.232.127]:29083 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S263408AbTJLDme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 23:42:34 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: Problems with Maxtor 120 GB drive
Date: Sun, 12 Oct 2003 02:43:19 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbohfu7.1mb.denebeim@hotblack.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
X-SA-Exim-Mail-From: news@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize this isn't the right place to be asking this, but people
here are very helpful and it's the only place I could think of to ask.

I just purchased a Maxtor 120GB MXTL01P120 hard drive and when I tried
to install it with Redhat it wrote over the partition table describing
it as only 8GB.  I tried doing linux rescue and lilo complained that
the physical and logical disk sizes did not match (logical was the
correct size, physical was the 8GB).

Any idea what could be causing this?

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
